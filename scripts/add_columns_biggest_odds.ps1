# Add id, user_id, contest_id columns to the front of all *cr_biggest_odds.csv files.
# Usage: .\add_columns_biggest_odds.ps1 -Path "C:\path\to\data_files"
# If no path is provided, searches from the current directory.

param(
    [string]$Path = (Get-Location).Path
)

$NewCols = "id,user_id,contest_id"
$FilesFound = 0
$FilesUpdated = 0

Write-Host "Searching for *cr_biggest_odds.csv files in: $Path"
Write-Host "-----------------------------------------------------------"

$files = Get-ChildItem -Path $Path -Filter "*cr_biggest_odds.csv" -Recurse

foreach ($file in $files) {
    $FilesFound++
    Write-Host "Processing: $($file.FullName)"

    # Read file content line by line
    $lines = @(Get-Content -Path $file.FullName -Encoding UTF8)

    if ($null -eq $lines -or $lines.Count -eq 0) {
        Write-Host "  Skipped: file is empty"
        continue
    }

    # Build updated lines
    $updatedLines = @()

    # Prepend new columns to header
    $updatedLines += "$NewCols,$($lines[0])"

    # Prepend empty values to each data row
    for ($i = 1; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $updatedLines += ",,,$line"
    }

    # Join with CRLF and write as raw bytes to avoid any line ending issues
    $finalContent = $updatedLines -join "`r`n"
    [System.IO.File]::WriteAllText($file.FullName, $finalContent, [System.Text.Encoding]::UTF8)

    $FilesUpdated++
    Write-Host "  Done"
}

Write-Host "-----------------------------------------------------------"
Write-Host "Files found:   $FilesFound"
Write-Host "Files updated: $FilesUpdated"