# Combines all .sql files found under the contest_results folder into a single .sql file.
#
# Usage:
#   .\combine_sql.ps1 -Path "C:\path\to\data_files\contest_results" -Output "C:\path\to\all_inserts.sql"
#
# If -Path is omitted, uses the current directory.
# If -Output is omitted, writes all_inserts.sql into the -Path folder.

param(
    [string]$Path   = (Get-Location).Path,
    [string]$Output = ""
)

if ($Output -eq "") {
    $Output = Join-Path $Path "all_inserts.sql"
}

$sqlFiles = Get-ChildItem -Path $Path -Recurse -Filter "*.sql" |
    Sort-Object FullName

if ($sqlFiles.Count -eq 0) {
    Write-Host "No .sql files found under: $Path"
    exit
}

Write-Host "Found $($sqlFiles.Count) SQL file(s). Combining into:"
Write-Host "  $Output"
Write-Host "-----------------------------------------------------------"

$writer = [System.IO.StreamWriter]::new($Output, $false, [System.Text.Encoding]::UTF8)

foreach ($file in $sqlFiles) {
    Write-Host "  Adding: $($file.FullName)"
    $writer.WriteLine("-- ============================================================")
    $writer.WriteLine("-- $($file.FullName)")
    $writer.WriteLine("-- ============================================================")
    $writer.WriteLine("")
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $writer.WriteLine($content)
    $writer.WriteLine("")
}

$writer.Close()

Write-Host "-----------------------------------------------------------"
Write-Host "Done. Output: $Output"