# Generates a .sql file with INSERT statements for every .csv file found
# under the contest_results folder tree.
#
# Table routing:
#   *cr_general.csv        -> cr_general
#   *cr_biggest_odds.csv   -> cr_biggest_odds
#   *cr_winning_streak.csv -> cr_winning_strick   (DB table has the typo)
#
# Rules:
#   - Empty id column      -> UUID()
#   - Empty string values  -> NULL  (for nullable columns)
#   - Numeric columns with empty value -> NULL
#   - String values are single-quoted and escaped
#
# Usage:
#   .\generate_insert_sql.ps1 -Path "C:\path\to\data_files\contest_results"
# If no path is provided, uses the current directory.

param(
    [string]$Path = (Get-Location).Path
)

# ---------- helpers ----------------------------------------------------------

function Get-HeaderIndex {
    param([string[]]$Headers, [string]$Name)
    for ($i = 0; $i -lt $Headers.Count; $i++) {
        if ($Headers[$i].Trim().TrimStart([char]0xFEFF) -eq $Name) { return $i }
    }
    return -1
}

function Parse-CsvLines {
    param([string]$FilePath)
    $raw   = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    $lines = $raw -split "`r`n|`n|`r" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    return $lines
}

# Columns that are purely numeric in the DB (no quoting, empty -> NULL)
$NumericColumns = @(
    'annual_points','place','final_bets_count','orig_bets_count',
    'won','lost','units','roi','active_days',
    'user_pick_value','strick_length','strick_avg_odds',
    'action_value','sum_annual_points','best_place','best_place_count',
    'second_best_place','second_best_place_count','third_best_place','avg_roi'
)

function Format-SqlValue {
    param([string]$ColName, [string]$RawValue)

    $val = $RawValue.Trim()

    # Empty id -> UUID()
    if ($ColName -eq 'id') {
        if ($val -eq '') { return 'UUID()' }
    }

    # Empty value -> NULL
    if ($val -eq '') { return 'NULL' }

    # Numeric columns -> unquoted
    if ($NumericColumns -contains $ColName) {
        return $val
    }

    # String columns -> escape single quotes and wrap
    $escaped = $val -replace "'", "''"
    return "'$escaped'"
}

# Map filename pattern to DB table name
function Get-TableName {
    param([string]$FileName)
    if ($FileName -match 'cr_general')        { return 'cr_general' }
    if ($FileName -match 'cr_biggest_odds')   { return 'cr_biggest_odds' }
    if ($FileName -match 'cr_winning_streak') { return 'cr_winning_strick' }   # DB typo preserved
    return $null
}

# ---------- main -------------------------------------------------------------

$FilesFound   = 0
$FilesWritten = 0
$FilesSkipped = 0
$Errors       = 0

Write-Host "Searching for contest result CSVs in: $Path"
Write-Host "-----------------------------------------------------------"

$csvFiles = Get-ChildItem -Path $Path -Recurse -Filter "*.csv" |
    Where-Object { $_.Name -match 'cr_general|cr_biggest_odds|cr_winning_streak' }

foreach ($csvFile in $csvFiles) {
    $FilesFound++

    $tableName = Get-TableName -FileName $csvFile.Name
    if ($null -eq $tableName) {
        Write-Host "SKIP (unknown table): $($csvFile.FullName)"
        $FilesSkipped++
        continue
    }

    Write-Host "Processing [$tableName]: $($csvFile.FullName)"

    $lines = Parse-CsvLines -FilePath $csvFile.FullName
    if ($lines.Count -lt 2) {
        Write-Host "  Skipped: no data rows"
        $FilesSkipped++
        continue
    }

    # Parse header - strip BOM from first column name
    $rawHeaders = $lines[0] -split ","
    $headers = @()
    for ($i = 0; $i -lt $rawHeaders.Count; $i++) {
        $h = $rawHeaders[$i].Trim().TrimStart([char]0xFEFF)
        $headers += $h
    }

    $colList = ($headers | ForEach-Object { "`$_" }) -join ', '
    # Build the column list string properly
    $colList = ($headers -join ', ')

    $sqlLines = @()
    $sqlLines += "-- Auto-generated INSERT statements"
    $sqlLines += "-- Source: $($csvFile.Name)"
    $sqlLines += "-- Table:  $tableName"
    $sqlLines += ""

    $dataRowCount = 0

    for ($i = 1; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ([string]::IsNullOrWhiteSpace($line)) { continue }

        # Split on comma - simple split (values in these CSVs have no quoted commas)
        $cols = $line -split ","

        # Pad with empty strings if row has fewer columns than header
        while ($cols.Count -lt $headers.Count) {
            $cols += ""
        }

        $values = @()
        for ($j = 0; $j -lt $headers.Count; $j++) {
            $colName  = $headers[$j]
            $rawVal   = if ($j -lt $cols.Count) { $cols[$j] } else { '' }
            $values  += Format-SqlValue -ColName $colName -RawValue $rawVal
        }

        $valueList = $values -join ', '
        $sqlLines += "INSERT INTO ``$tableName`` ($colList) VALUES ($valueList);"
        $dataRowCount++
    }

    if ($dataRowCount -eq 0) {
        Write-Host "  Skipped: no valid data rows after parsing"
        $FilesSkipped++
        continue
    }

    # Write .sql file alongside the .csv file
    $sqlPath = [System.IO.Path]::ChangeExtension($csvFile.FullName, ".sql")
    $finalContent = $sqlLines -join "`r`n"

    try {
        [System.IO.File]::WriteAllText($sqlPath, $finalContent, [System.Text.Encoding]::UTF8)
        Write-Host "  Written ($dataRowCount rows): $sqlPath"
        $FilesWritten++
    } catch {
        Write-Host "  ERROR writing file: $_"
        $Errors++
    }
}

Write-Host ""
Write-Host "==========================================="
Write-Host "CSVs found:      $FilesFound"
Write-Host "SQL files written: $FilesWritten"
Write-Host "Skipped:         $FilesSkipped"
Write-Host "Errors:          $Errors"