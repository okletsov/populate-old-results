# Combines all *cr_finance_awards.sql files found under the contest_results folder into a single .sql file.
#
# Usage:
#   .\scripts\combine_finance_awards_sql.ps1 -Path ".\data_files\contest_results" -Output ".\data_files\sql\all_finance_awards.sql"
#
# If -Path is omitted, uses the current directory.
# If -Output is omitted, writes all_finance_awards.sql into the -Path folder.

param(
    [string]$Path   = (Get-Location).Path,
    [string]$Output = ""
)

if ($Output -eq "") {
    $Output = Join-Path $Path "all_finance_awards.sql"
}

$sqlFiles = Get-ChildItem -Path $Path -Recurse -Filter "*cr_finance_awards.sql" |
    Sort-Object FullName

if ($sqlFiles.Count -eq 0) {
    Write-Host "No *cr_finance_awards.sql files found under: $Path"
    exit
}

Write-Host "Found $($sqlFiles.Count) finance awards SQL file(s). Combining into:"
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
