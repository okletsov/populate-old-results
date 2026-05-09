---
name: contest-results-populator
description: Populate contest result CSV files for this repository from raw contest text and OCR screenshots. Use when the user asks to fill or update cr_general.csv, cr_biggest_odds.csv, or cr_winning_streak.csv for a contest key such as 2013_spring, including workflows that read data_files/data_to_process/<contest>, generate missing OCR JSON sidecars, and update data_files/contest_results/<contest>.
---

# Contest Results Populator

## Workflow

Run from the `populate-old-results` repository root. Read `AGENTS.md` first and follow it as the source of truth for encoding, source priority, OCR, CSV headers, seasonal bet counts, annual points, and user notifications.

Use the bundled script:

```powershell
node .codex/skills/contest-results-populator/scripts/populate-contest-results.mjs --contest 2013_spring
```

The default mode is a dry run. When the user explicitly asks to populate or implement the result, run:

```powershell
node .codex/skills/contest-results-populator/scripts/populate-contest-results.mjs --contest 2013_spring --apply
```

Use `--skip-ocr` only when OCR JSON sidecars already exist or when the user wants an offline parse.

If the folder contains **`Итоговые результаты.txt`**, the script treats it as the raw results file: with **`--apply`** it **renames** it to **`<contest>_raw.txt`** (for example `2014_summer_raw.txt`) before parsing. On a **dry run** it reads that file without renaming and prints a notification suggesting `--apply` to rename.

## What The Script Does

- Resolves input files from `data_files/data_to_process/<contest>/`.
- Resolves output CSVs from `data_files/contest_results/<contest>/`.
- For monthly contest keys such as `2017_spring_mon_1`, uses `2017_spring` as the folder and the full key as the CSV prefix.
- Reads raw text as Windows-1251 (from `<contest>_raw.txt`, or from `Итоговые результаты.txt` when the standard name is not present).
- Generates missing OCR JSON sidecars from screenshots with `npm run ocr`.
- Parses raw placements, ROI, explicit bet counts, incomplete/disqualified status, and side awards.
- Parses OCR JSON `Total` rows for Total Predictions, Won, Lost, Units, and optional OCR ROI.
- Preserves existing CSV headers exactly.
- Normalizes `cr_general` values:
  - If `orig_bets_count` is blank after processing, sets it to `100`.
  - If `won` is blank and `roi` is present, sets `won = 100 + roi`.
  - Strips a leading `+` from positive ROI values (stores ROI without `%`).
- Writes these files when `--apply` is used:
  - `<contest>_cr_general.csv`
  - `<contest>_cr_biggest_odds.csv`
  - `<contest>_cr_winning_streak.csv`

## Review Rules

After running the script, inspect the printed notifications. Call out anything important in the final answer, especially:

- raw text and OCR disagreements on ROI, bet counts, or placement.
- raw text `Won` / `Lost` differing from OCR screenshot totals for the same participant.
- derived `won` (computed as `100 + roi` when raw `won` is missing) differing from OCR `Won` (derived value is kept).
- seasonal `orig_bets_count != 100`.
- missing raw side-award data for biggest odds or winning streak.
- OCR JSON rows that could not be parsed into Total Predictions, Won, Lost, and Units.

For seasonal contests, `final_bets_count` is always `100`; for monthly contests, do not apply that fixed count rule.

## Validation

After applying updates:

```powershell
Import-Csv data_files/contest_results/<folder>/<contest>_cr_general.csv
Import-Csv data_files/contest_results/<folder>/<contest>_cr_biggest_odds.csv
Import-Csv data_files/contest_results/<folder>/<contest>_cr_winning_streak.csv
```

Confirm headers remain unchanged and report generated JSON files plus changed CSV rows.
