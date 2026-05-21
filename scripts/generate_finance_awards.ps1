# =============================================================================
# generate_finance_awards.ps1
#
# Generates one .sql file per contest folder under contest_results\.
# Each file contains:
#   - cr_finance INSERTs  for every award category
#   - finance_offset INSERTs mirroring each award  (finance_action_id = 13)
#
# Finance action IDs:
#   1  Seasonal 1st   2  Seasonal 2nd   3  Seasonal 3rd
#   4  Monthly  1st   5  Monthly  2nd   6  Monthly  3rd
#   7  Winning streak   8  Biggest odds
#   13 Deposit  (offset row – mirrors every award so saldo stays balanced)
#
# Award value = ROUND( pct/100 * entrance_fee * participant_count )
#
# Usage:
#   .\scripts\generate_finance_awards.ps1 `
#       -ContestResultsPath ".data_files\contest_results" `
#       -DataFilesPath      ".\data_files\sql"
#
# Paths default to ..\data_files\contest_results and ..\data_files relative
# to the script location if omitted.
# =============================================================================

param(
    [string]$ContestResultsPath = "",
    [string]$DataFilesPath      = ""
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($ContestResultsPath -eq "") {
    $ContestResultsPath = Join-Path $ScriptDir "..\data_files\contest_results"
}
if ($DataFilesPath -eq "") {
    $DataFilesPath = Join-Path $ScriptDir "..\data_files"
}

$ContestResultsPath = (Resolve-Path $ContestResultsPath).Path
$DataFilesPath      = (Resolve-Path $DataFilesPath).Path

Write-Host "Contest results : $ContestResultsPath"
Write-Host "Data files root : $DataFilesPath"
Write-Host ""

# =============================================================================
# HELPERS
# =============================================================================

# Returns an array of plain [hashtable] rows (NOT PSCustomObject).
# Plain hashtables allow $row["1m1st"] without the silent-null PSCustomObject
# bug that occurs with property names beginning with a digit.
function Parse-CsvToHashtables {
    param([string]$FilePath)
    $raw   = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    $lines = $raw -split "`r`n|`n|`r" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    if ($lines.Count -lt 2) { return @() }

    $rawHeaders = ($lines[0].TrimStart([char]0xFEFF)) -split ","
    $headers    = @()
    foreach ($h in $rawHeaders) { $headers += $h.Trim() }

    $result = [System.Collections.Generic.List[hashtable]]::new()
    for ($i = 1; $i -lt $lines.Count; $i++) {
        $cols = $lines[$i] -split ","
        $row  = @{}
        for ($j = 0; $j -lt $headers.Count; $j++) {
            $row[$headers[$j]] = if ($j -lt $cols.Count) { $cols[$j].Trim() } else { "" }
        }
        $result.Add($row)
    }
    return ,$result   # comma forces return as single array even when 1 element
}

# Parse a seasonal or monthly cr_general csv.
# Returns: (nickname->user_id hashtable), contest_id string, row count
function Parse-GeneralCsv {
    param([string]$FilePath)
    $rows      = Parse-CsvToHashtables -FilePath $FilePath
    $map       = @{}
    $contestId = ""
    foreach ($r in $rows) {
        if ($r["nickname"] -ne "" -and $r["user_id"] -ne "") {
            $map[$r["nickname"]] = $r["user_id"]
        }
        if ($contestId -eq "" -and $r["contest_id"] -ne "") {
            $contestId = $r["contest_id"]
        }
    }
    return $map, $contestId, $rows.Count
}

# Append a cr_finance row + a matching finance_offset row to $Lines.
function Add-AwardInsert {
    param(
        [System.Collections.Generic.List[string]]$Lines,
        [string]$UserId,
        [string]$ContestId,
        [int]   $ActionId,
        [int]   $Amount,
        [string]$Comment
    )
    $safe = $Comment -replace "'", "''"
    $Lines.Add("-- $Comment")
    $Lines.Add("INSERT INTO ``cr_finance`` (id, user_id, contest_id, finance_action_id, action_value) VALUES (UUID(), '$UserId', '$ContestId', $ActionId, $Amount);")
    $Lines.Add("INSERT INTO ``finance_offset`` (id, user_id, finance_action_id, action_value, action_date, notes) VALUES (UUID(), '$UserId', 13, -$Amount, NOW(), '$safe');")
    $Lines.Add("")
}

# Calculate award: ROUND( pct/100 * pool ).  Returns 0 for blank/null pct.
function Calc-Award {
    param([string]$PctStr, [int]$Pool)
    if ([string]::IsNullOrWhiteSpace($PctStr)) { return 0 }
    return [int][Math]::Round([double]$PctStr / 100.0 * $Pool)
}

# =============================================================================
# LOAD LOOKUP DATA
# =============================================================================

$RulesMap    = @{}
foreach ($r in (Parse-CsvToHashtables -FilePath (Join-Path $DataFilesPath "award_rules.csv"))) {
    $RulesMap["$($r["year"])_$($r["season"])"] = $r
}

$ContestMeta = @{}
foreach ($c in (Parse-CsvToHashtables -FilePath (Join-Path $DataFilesPath "missing_contests.csv"))) {
    $ContestMeta["$($c["year"])_$($c["season"])"] = $c
}

# =============================================================================
# MAIN LOOP
# =============================================================================

$Folders      = Get-ChildItem -Path $ContestResultsPath -Directory | Sort-Object Name
$TotalWritten = 0
$TotalSkipped = 0

foreach ($folder in $Folders) {
    $folderName = $folder.Name

    if ($folderName -notmatch '^(\d{4})_(.+)$') {
        Write-Host "SKIP (unrecognised folder name): $folderName"
        $TotalSkipped++; continue
    }

    $year   = $Matches[1]
    $season = $Matches[2].Substring(0,1).ToUpper() + $Matches[2].Substring(1).ToLower()
    $key    = "${year}_${season}"

    if (-not $RulesMap.ContainsKey($key)) {
        Write-Host "SKIP (no award rules for '$key'): $folderName"
        $TotalSkipped++; continue
    }
    if (-not $ContestMeta.ContainsKey($key)) {
        Write-Host "SKIP (no contest meta for '$key'): $folderName"
        $TotalSkipped++; continue
    }

    # All rule values are fetched via hashtable indexer [$key] — safe for
    # column names like "1m1st" that would silently return null on PSCustomObject.
    $rules       = $RulesMap[$key]
    $entranceFee = [int]$ContestMeta[$key]["entrance_fee"]

    # --- seasonal cr_general -------------------------------------------------
    $seasonalCsv = Get-ChildItem -Path $folder.FullName -File |
        Where-Object { $_.Name -match 'cr_general\.csv$' -and $_.Name -notmatch 'mon_\d' } |
        Select-Object -First 1

    if ($null -eq $seasonalCsv) {
        Write-Host "SKIP (no seasonal cr_general csv): $folderName"
        $TotalSkipped++; continue
    }

    $nickMap, $seasonalContestId, $participantCount =
        Parse-GeneralCsv -FilePath $seasonalCsv.FullName

    if ($participantCount -eq 0 -or $seasonalContestId -eq "") {
        Write-Host "SKIP (empty seasonal cr_general): $folderName"
        $TotalSkipped++; continue
    }

    $pool = $entranceFee * $participantCount
    Write-Host "Processing: $folderName  |  n=$participantCount  fee=$entranceFee  pool=$pool"

    $sql = [System.Collections.Generic.List[string]]::new()
    $sql.Add("-- ============================================================")
    $sql.Add("-- Finance awards: $folderName")
    $sql.Add("-- Pool: $participantCount x $entranceFee = $pool")
    $sql.Add("-- ============================================================")
    $sql.Add("")

    # -------------------------------------------------------------------------
    # Seasonal  (1=1st  2=2nd  3=3rd)
    # -------------------------------------------------------------------------
    $sql.Add("-- ------ Seasonal awards ------")
    $sql.Add("")

    $sRows = Parse-CsvToHashtables -FilePath $seasonalCsv.FullName

    @(
        @{ p="1"; aid=1; rk="s1st" },
        @{ p="2"; aid=2; rk="s2nd" },
        @{ p="3"; aid=3; rk="s3rd" }
    ) | ForEach-Object {
        $cfg    = $_
        $pctStr = $rules[$cfg.rk]
        if ([string]::IsNullOrWhiteSpace($pctStr)) { return }

        $amt = Calc-Award -PctStr $pctStr -Pool $pool
        if ($amt -eq 0) { return }

        $winner = $sRows | Where-Object { $_["place"] -eq $cfg.p } | Select-Object -First 1
        if ($null -eq $winner) {
            Write-Warning "  Seasonal place $($cfg.p) not found – $folderName"; return
        }
        $uid = $winner["user_id"]
        if ($uid -eq "") {
            Write-Warning "  Seasonal place $($cfg.p): user_id empty for '$($winner["nickname"])'"; return
        }
        $lbl = @{"1"="1st";"2"="2nd";"3"="3rd"}[$cfg.p]
        Add-AwardInsert $sql $uid $seasonalContestId $cfg.aid $amt "Seasonal $lbl – $($winner["nickname"]) ($folderName)"
    }

    # -------------------------------------------------------------------------
    # Monthly  (4=1st  5=2nd  6=3rd) for month 1 and month 2
    # -------------------------------------------------------------------------
    foreach ($mn in @(1, 2)) {
        $k1 = "${mn}m1st";  $k2 = "${mn}m2nd";  $k3 = "${mn}m3rd"
        $p1 = $rules[$k1];  $p2 = $rules[$k2];  $p3 = $rules[$k3]

        $anyRule = (-not [string]::IsNullOrWhiteSpace($p1)) -or
                   (-not [string]::IsNullOrWhiteSpace($p2)) -or
                   (-not [string]::IsNullOrWhiteSpace($p3))
        if (-not $anyRule) { continue }

        $monCsv = Get-ChildItem -Path $folder.FullName -File |
            Where-Object { $_.Name -match "mon_${mn}_cr_general\.csv$" } |
            Select-Object -First 1

        if ($null -eq $monCsv) {
            Write-Host "  Month $mn : csv not found, skipping"
            continue
        }

        $dummy1, $monContestId, $dummy2 = Parse-GeneralCsv -FilePath $monCsv.FullName
        if ($monContestId -eq "") {
            Write-Warning "  Month $mn : contest_id missing in $($monCsv.Name)"; continue
        }

        $sql.Add("-- ------ Monthly $mn awards ------")
        $sql.Add("")

        $mRows = Parse-CsvToHashtables -FilePath $monCsv.FullName

        @(
            @{ p="1"; aid=4; pct=$p1 },
            @{ p="2"; aid=5; pct=$p2 },
            @{ p="3"; aid=6; pct=$p3 }
        ) | ForEach-Object {
            $cfg = $_
            if ([string]::IsNullOrWhiteSpace($cfg.pct)) { return }

            $amt = Calc-Award -PctStr $cfg.pct -Pool $pool
            if ($amt -eq 0) { return }

            $winner = $mRows | Where-Object { $_["place"] -eq $cfg.p } | Select-Object -First 1
            if ($null -eq $winner) {
                Write-Warning "  Monthly $mn place $($cfg.p) not found – $folderName"; return
            }
            $uid = $winner["user_id"]
            if ($uid -eq "") {
                Write-Warning "  Monthly $mn place $($cfg.p): user_id empty for '$($winner["nickname"])'"; return
            }
            $lbl = @{"1"="1st";"2"="2nd";"3"="3rd"}[$cfg.p]
            Add-AwardInsert $sql $uid $monContestId $cfg.aid $amt "Monthly $mn $lbl – $($winner["nickname"]) ($folderName)"
        }
    }

    # -------------------------------------------------------------------------
    # Winning streak  (7)
    # -------------------------------------------------------------------------
    $streakPct = $rules["streak"]
    if (-not [string]::IsNullOrWhiteSpace($streakPct)) {
        $amt = Calc-Award -PctStr $streakPct -Pool $pool
        if ($amt -gt 0) {
            $sql.Add("-- ------ Winning streak award ------")
            $sql.Add("")

            $streakCsv = Get-ChildItem -Path $folder.FullName -File |
                Where-Object { $_.Name -match 'cr_winning_streak\.csv$' } |
                Select-Object -First 1

            if ($null -ne $streakCsv) {
                foreach ($sr in (Parse-CsvToHashtables -FilePath $streakCsv.FullName)) {
                    $uid = $sr["user_id"]
                    if ($uid -eq "") {
                        Write-Warning "  Streak: missing user_id in $($streakCsv.Name)"; continue
                    }
                    Add-AwardInsert $sql $uid $seasonalContestId 7 $amt "Winning streak – $($sr["nickname"]) ($folderName)"
                }
            } else {
                Write-Warning "  No cr_winning_streak.csv in $folderName"
            }
        }
    }

    # -------------------------------------------------------------------------
    # Biggest odds  (8) — split equally among tied winners
    # -------------------------------------------------------------------------
    $oddsPct = $rules["odds"]
    if (-not [string]::IsNullOrWhiteSpace($oddsPct)) {
        $totalOddsAmt = Calc-Award -PctStr $oddsPct -Pool $pool
        if ($totalOddsAmt -gt 0) {
            $sql.Add("-- ------ Biggest odds award ------")
            $sql.Add("")

            $oddsCsv = Get-ChildItem -Path $folder.FullName -File |
                Where-Object { $_.Name -match 'cr_biggest_odds\.csv$' } |
                Select-Object -First 1

            if ($null -ne $oddsCsv) {
                $allOdds = Parse-CsvToHashtables -FilePath $oddsCsv.FullName
                
                # Count rows with non-empty user_id to calculate split amount
                $validOddsCount = 0
                foreach ($row in $allOdds) {
                    if (-not [string]::IsNullOrWhiteSpace($row["user_id"])) {
                        $validOddsCount++
                    }
                }
                
                if ($validOddsCount -gt 0) {
                    $splitAmt = [int][Math]::Round($totalOddsAmt / $validOddsCount)
                    
                    foreach ($or in $allOdds) {
                        $uid = $or["user_id"]
                        if ([string]::IsNullOrWhiteSpace($uid)) {
                            continue
                        }
                        Add-AwardInsert $sql $uid $seasonalContestId 8 $splitAmt "Biggest odds – $($or["nickname"]) ($folderName)"
                    }
                }
            } else {
                Write-Warning "  No cr_biggest_odds.csv in $folderName"
            }
        }
    }

    # -------------------------------------------------------------------------
    # Write SQL file
    # -------------------------------------------------------------------------
    $outPath = Join-Path $folder.FullName "${folderName}_cr_finance_awards.sql"
    [System.IO.File]::WriteAllText($outPath, ($sql -join "`r`n"), [System.Text.Encoding]::UTF8)
    Write-Host "  -> $outPath"
    $TotalWritten++
}

Write-Host ""
Write-Host "==========================================="
Write-Host "SQL files written : $TotalWritten"
Write-Host "Skipped           : $TotalSkipped"