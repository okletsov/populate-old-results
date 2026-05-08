# Agent Instructions

These rules apply to AI-assisted work in this repository.

## Contest Result Data

- Raw contest result text files may be encoded as Windows-1251. If Cyrillic text appears corrupted in the terminal, reread the file using Windows-1251 before parsing.
- Do not modify existing populated contest result CSV files unless the user explicitly requests it. Header-only placeholder CSV files may be populated when requested.
- Preserve existing CSV headers exactly. Use the matching template or an existing contest file header as the source of truth.

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
