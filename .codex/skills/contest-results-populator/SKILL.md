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

```powershell
node .codex/skills/contest-results-populator/scripts/populate-contest-results.mjs --contest 2013_spring --apply --clamp-seasonal-orig-max-100
```

Use `--skip-ocr` only when OCR JSON sidecars already exist or when the user wants an offline parse.

Optional: **`--clamp-seasonal-orig-max-100`** — for **non-monthly** contests only, after merge, sets `orig_bets_count` greater than **100** to **100** in `cr_general`, logs one notification per clamped row, and skips the usual “seasonal orig_bets_count is not 100” warning for those rows when the value was above 100. **Default runs do not clamp** (see [AGENTS.md](../../../AGENTS.md): do not silently override OCR/raw without an explicit choice).

If the folder contains **`Итоговые результаты.txt`**, the script treats it as the raw results file: with **`--apply`** it **renames** it to **`<contest>_raw.txt`** (for example `2014_summer_raw.txt`) before parsing. On a **dry run** it reads that file without renaming and prints a notification suggesting `--apply` to rename.

## What The Script Does

- Resolves input files from `data_files/data_to_process/<contest>/`.
- Resolves output CSVs from `data_files/contest_results/<contest>/`.
- For monthly contest keys such as `2017_spring_mon_1`, uses `2017_spring` as the folder and the full key as the CSV prefix.
- Reads raw text as Windows-1251 (from `<contest>_raw.txt`, or from `Итоговые результаты.txt` when the standard name is not present).
- Generates missing OCR JSON sidecars from screenshots with `npm run ocr`.
- Parses raw placements, ROI, explicit bet counts, incomplete/disqualified status, and side awards.
- **Placements:** Recognizes both `N место. Nickname - …` / `N place. …` and alternate **numbered lines** `N. Nickname …` (ROI from `ROI:` or `%`).
- **Biggest odds:** One raw line can list **several winners** with the same coefficient, separated by **commas** or **и** (e.g. `… - AjaxSpring, ka1manua, Deagle - 10.00`). Each nickname becomes one CSV row. Odds lines are detected using coefficient wording including common typos **`кофф`** / **`коф.`** alongside `коэффициент`, `коеф`, `odds`, etc.
- **Winning streak:** If the raw line includes average coefficient text such as `(ср. коф. 1.86)`, **`strick_avg_odds`** is filled when the pattern matches.
- Parses OCR JSON `Total` rows for Total Predictions, Won, Lost, Units, and optional OCR ROI.
- Preserves existing CSV headers exactly.
- Normalizes `cr_general` values:
  - If `orig_bets_count` is blank after processing, sets it to `100`.
  - If `won` is blank and `roi` is present, sets `won = 100 + roi`.
  - Sets `units = roi` (exception: `2012_autumn`).
  - Strips a leading `+` from positive ROI values (stores ROI without `%`).
  - With **`--clamp-seasonal-orig-max-100`**, caps seasonal `orig_bets_count` at **100** when it would otherwise exceed 100 (see above).
- Writes these files when `--apply` is used:
  - `<contest>_cr_general.csv`
  - `<contest>_cr_biggest_odds.csv`
  - `<contest>_cr_winning_streak.csv`

## Review Rules

After running the script, inspect the printed notifications. Call out anything important in the final answer, especially:

- raw text and OCR disagreements on ROI, bet counts, or placement.
- raw text `Won` / `Lost` differing from OCR screenshot totals for the same participant.
- derived `won` (computed as `100 + roi` when raw `won` is missing) differing from OCR `Won` (derived value is kept).
- derived `units` (always `units = roi`, except `2012_autumn`) differing from OCR `Units` (derived value is kept).
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
