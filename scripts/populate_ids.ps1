# Populates user_id and contest_id in *cr_biggest_odds.csv and *cr_winning_streak.csv
# by looking up nickname in the matching *cr_general.csv in the same folder.
# Usage: .\populate_ids.ps1 -Path "C:\path\to\contest_results"
# If no path is provided, searches from the current directory.

param(
    [string]$Path = (Get-Location).Path
)

$FilesProcessed = 0
$FilesSkipped = 0
$Errors = 0

function Get-HeaderIndex {
    param([string[]]$Headers, [string]$Name)
    for ($i = 0; $i -lt $Headers.Count; $i++) {
        if ($Headers[$i].Trim().TrimStart([char]0xFEFF) -eq $Name) { return $i }
    }
    return -1
}

function Parse-Csv {
    param([string]$FilePath)
    $raw = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    $lines = $raw -split "`r`n|`n|`r" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    return $lines
}

# Find all folders that contain a *cr_general.csv (but not *mon_*cr_general.csv)
$generalFiles = Get-ChildItem -Path $Path -Recurse -File |
    Where-Object { $_.Name -match "cr_general\.csv$" -and $_.Name -notmatch "mon_\d" }

foreach ($generalFile in $generalFiles) {
    $folder = $generalFile.DirectoryName
    $folderName = Split-Path $folder -Leaf

    Write-Host "`nFolder: $folderName"
    Write-Host "  General: $($generalFile.Name)"

    # --- Parse cr_general.csv ---
    $generalLines = Parse-Csv -FilePath $generalFile.FullName
    if ($generalLines.Count -lt 2) {
        Write-Host "  Skipped: general file has no data rows"
        $FilesSkipped++
        continue
    }

    $generalHeaders = $generalLines[0] -split ","
    $nicknameIdx = Get-HeaderIndex $generalHeaders "nickname"
    $userIdIdx   = Get-HeaderIndex $generalHeaders "user_id"
    $contestIdIdx = Get-HeaderIndex $generalHeaders "contest_id"

    if ($nicknameIdx -lt 0 -or $userIdIdx -lt 0 -or $contestIdIdx -lt 0) {
        Write-Host "  ERROR: Could not find required columns in general file"
        $Errors++
        continue
    }

    # Build nickname -> user_id map and grab contest_id from first data row
    $nicknameToUserId = @{}
    $contestId = ""

    for ($i = 1; $i -lt $generalLines.Count; $i++) {
        $cols = $generalLines[$i] -split ","
        if ($cols.Count -le $userIdIdx) { continue }
        $nickname  = $cols[$nicknameIdx].Trim()
        $userId    = $cols[$userIdIdx].Trim()
        $cId       = $cols[$contestIdIdx].Trim()
        if ($nickname -ne "") { $nicknameToUserId[$nickname] = $userId }
        if ($contestId -eq "" -and $cId -ne "") { $contestId = $cId }
    }

    if ($contestId -eq "") {
        Write-Host "  ERROR: No contest_id found in general file"
        $Errors++
        continue
    }

    # --- Process target files in same folder ---
    $targetFiles = Get-ChildItem -Path $folder -File |
        Where-Object { $_.Name -match "cr_biggest_odds\.csv$" -or $_.Name -match "cr_winning_streak\.csv$" }

    foreach ($targetFile in $targetFiles) {
        Write-Host "  Processing: $($targetFile.Name)"

        $targetLines = Parse-Csv -FilePath $targetFile.FullName
        if ($targetLines.Count -lt 2) {
            Write-Host "    Skipped: no data rows"
            $FilesSkipped++
            continue
        }

        $targetHeaders = $targetLines[0] -split ","
        $t_idIdx        = Get-HeaderIndex $targetHeaders "id"
        $t_userIdIdx    = Get-HeaderIndex $targetHeaders "user_id"
        $t_contestIdIdx = Get-HeaderIndex $targetHeaders "contest_id"
        $t_nicknameIdx  = Get-HeaderIndex $targetHeaders "nickname"

        if ($t_userIdIdx -lt 0 -or $t_contestIdIdx -lt 0 -or $t_nicknameIdx -lt 0) {
            Write-Host "    ERROR: Required columns not found in target file"
            $Errors++
            continue
        }

        $updatedLines = @($targetLines[0])  # keep header as-is

        for ($i = 1; $i -lt $targetLines.Count; $i++) {
            $cols = $targetLines[$i] -split ","
            $nickname = $cols[$t_nicknameIdx].Trim()

            # Populate user_id
            if ($nicknameToUserId.ContainsKey($nickname)) {
                $cols[$t_userIdIdx] = $nicknameToUserId[$nickname]
            } else {
                Write-Host "    WARNING: No user_id match for nickname '$nickname'"
            }

            # Populate contest_id
            $cols[$t_contestIdIdx] = $contestId

            $updatedLines += ($cols -join ",")
        }

        # Write back with CRLF
        $finalContent = $updatedLines -join "`r`n"
        [System.IO.File]::WriteAllText($targetFile.FullName, $finalContent, [System.Text.Encoding]::UTF8)
        $FilesProcessed++
        Write-Host "    Done"
    }
}

Write-Host "`n==========================================="
Write-Host "Files updated: $FilesProcessed"
Write-Host "Files skipped: $FilesSkipped"
Write-Host "Errors:        $Errors"