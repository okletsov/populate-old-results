# Agent Instructions

These rules apply to AI-assisted work in this repository.

## Contest Result Data

- Raw contest result text files may be encoded as Windows-1251. If Cyrillic text appears corrupted in the terminal, reread the file using Windows-1251 before parsing.
- Do not modify existing populated contest result CSV files unless the user explicitly requests it. Header-only placeholder CSV files may be populated when requested.
- Preserve existing CSV headers exactly. Use the matching template or an existing contest file header as the source of truth.
- Store ROI as a numeric percentage value without `%`, using a dot decimal separator.
- Preserve numeric formatting from OCR totals where practical, including trailing decimals such as `45.0` and two-decimal unit values such as `-2.40`.
- Seasonal contests always use `final_bets_count = 100`; monthly contests do not use this fixed final count rule.
- For seasonal contests, `orig_bets_count` may be lower than `100` but must not be greater than `100`.
- If OCR or raw text implies `orig_bets_count > 100` for a seasonal contest, do not silently normalize it. Notify the user and report the source value.
- Notify the user when raw text and OCR disagree on ROI, bet counts, or placement, or when a seasonal participant has `orig_bets_count < 100`.

## OCR Screenshot Processing

- Use `npm run ocr -- --input <image> --output <json>` to generate OCR JSON sidecars for contest screenshots.
- For screenshot-derived profile stats, extract the row beginning with `Total` from the OCR JSON stats table.
- Map OCR total stats into `cr_general` columns as:
  - `final_bets_count`: final contest bet count, or Total Predictions when no separate final count is available.
  - `orig_bets_count`: Total Predictions, unless raw contest text gives an explicit different count.
  - `won`: Total `Won`.
  - `lost`: Total `Lost`.
  - `units`: Total `+/-`.
  - `roi`: ROI percentage without `%`.
- When populating completed participants from profile screenshots, set `final_bets_count` equal to `orig_bets_count` unless the raw contest text states otherwise.

## Source Priority

- Use raw contest text files as the source of truth for final placement, ROI, disqualification/incomplete status, and explicitly stated bet counts.
- Use OCR screenshot JSON as the source of truth for missing detailed profile stats such as `won`, `lost`, `units`, and Total Predictions.
- If OCR ROI differs from raw contest text, keep the raw contest text ROI.
- If OCR text recognition produces obvious noise around labels, prefer the numeric sequence in the `Total` stats row after confirming it matches the expected table shape.
- Raw text labels for biggest odds and winning streak may vary. Treat their wording flexibly, but preserve the meaning:
  - Biggest odds means highest winning odds, highest hit coefficient, or equivalent phrasing.
  - Winning streak means longest winning streak, most consecutive wins, or equivalent phrasing.

## Annual Points

Populate `annual_points` from the final contest placement count:

- Last place receives `1` point.
- Each place above it receives `+1` point until 4th place is reached.
- 3rd place receives `2` more points than 4th place.
- 2nd place receives `2` more points than 3rd place.
- 1st place receives `2` more points than 2nd place.

For example, a 9-participant contest receives annual points:

```text
place:          1  2  3  4  5  6  7  8  9
annual_points: 12 10 8  6  5  4  3  2  1
```
