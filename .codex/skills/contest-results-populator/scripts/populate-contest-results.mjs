#!/usr/bin/env node
import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, readdirSync, renameSync, writeFileSync } from "node:fs";
import path from "node:path";
import { TextDecoder } from "node:util";

const GENERAL_HEADER = [
  "annual_points",
  "nickname",
  "place",
  "final_bets_count",
  "orig_bets_count",
  "won",
  "lost",
  "units",
  "roi"
];
const BIGGEST_ODDS_HEADER = ["nickname", "user_pick_value"];
const WINNING_STREAK_HEADER = ["nickname", "strick_length", "strick_avg_odds"];

/** Default raw-results filename sometimes dropped into data_to_process (UTF-8). */
const FINAL_RESULTS_TXT = "\u0418\u0442\u043e\u0433\u043e\u0432\u044b\u0435 \u0440\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442\u044b.txt";

const options = parseArgs(process.argv.slice(2));
if (!options.contest) {
  fail(
    "Usage: node populate-contest-results.mjs --contest <contest_key> [--apply] [--skip-ocr] [--clamp-seasonal-orig-max-100]"
  );
}

const repoRoot = process.cwd();
const contest = options.contest;
const monthlyMatch = contest.match(/^(\d{4}_[a-z]+)_mon_\d+$/i);
const monthlyNumber = monthlyMatch ? Number(contest.match(/_mon_(\d+)$/i)?.[1] ?? 0) : null;
const folderKey = monthlyMatch ? monthlyMatch[1] : contest;
const isMonthly = Boolean(monthlyMatch);
const inputDir = resolveExistingInputDir(repoRoot, contest, folderKey);
const outputDir = path.join(repoRoot, "data_files", "contest_results", folderKey);
const prefix = contest;
const rawPrefix = folderKey;
const notes = [];

if (!existsSync(inputDir)) {
  fail(`Input directory does not exist: ${inputDir}`);
}
if (!existsSync(outputDir) && options.apply) {
  mkdirSync(outputDir, { recursive: true });
}

maybeRenameFinalResultsTxt(inputDir, rawPrefix, options.apply);

const rawText = readRawText(inputDir, outputDir, prefix, rawPrefix);
const raw = parseRawText(rawText, { isMonthly, monthlyNumber });

const jsonFiles = ensureOcrJsonSidecars(inputDir, options);
const monthlyMonthLabel = isMonthly ? calendarMonthLabel(folderKey, monthlyNumber) : "";
if (isMonthly && !monthlyMonthLabel) {
  fail(`Could not resolve calendar month for monthly contest key: ${contest}`);
}
const ocrByNickname = parseOcrJsonFiles(jsonFiles, { monthlyMonthLabel });
const rows = buildGeneralRows(raw.placements, ocrByNickname, {
  isMonthly,
  notes,
  contestKey: contest,
  monthlyMonthLabel,
  clampSeasonalOrigMax100: options.clampSeasonalOrigMax100
});
const awards = raw.awards;

const generalPath = path.join(outputDir, `${prefix}_cr_general.csv`);
const oddsPath = path.join(outputDir, `${prefix}_cr_biggest_odds.csv`);
const streakPath = path.join(outputDir, `${prefix}_cr_winning_streak.csv`);

const generalCsv = normalizeGeneralCsvText(mergeCsv(generalPath, GENERAL_HEADER, rows, "nickname", {
  replaceRows: isMonthly
}), {
  contestKey: prefix,
  isMonthly,
  clampSeasonalOrigMax100: options.clampSeasonalOrigMax100,
  notes
});
const oddsCsv = isMonthly ? "" : mergeCsv(
  oddsPath,
  BIGGEST_ODDS_HEADER,
  awards.biggestOdds ?? [],
  "nickname"
);
const streakCsv = isMonthly ? "" : mergeCsv(
  streakPath,
  WINNING_STREAK_HEADER,
  awards.winningStreak ? [awards.winningStreak] : [],
  "nickname"
);
const monthlyArtifacts = isMonthly ? [] : buildMonthlyArtifactsForSeason({
  rawText,
  jsonFiles,
  folderKey,
  outputDir,
  notes,
  clampSeasonalOrigMax100: options.clampSeasonalOrigMax100
});

if (options.apply) {
  writeFileSync(generalPath, generalCsv, "utf8");
  if (!isMonthly) {
    writeFileSync(oddsPath, oddsCsv, "utf8");
    writeFileSync(streakPath, streakCsv, "utf8");
    for (const artifact of monthlyArtifacts) {
      writeFileSync(artifact.generalPath, artifact.generalCsv, "utf8");
    }
  }
}

printSummary({
  apply: options.apply,
  contest,
  inputDir,
  outputDir,
  jsonFiles,
  rows,
  awards,
  generatedCsv: {
    general: generalCsv,
    odds: oddsCsv,
    streak: streakCsv
  },
  monthlyArtifacts,
  notes
});

function parseArgs(args) {
  const parsed = { apply: false, skipOcr: false, clampSeasonalOrigMax100: false, contest: "" };
  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];
    if (arg === "--contest") parsed.contest = args[++i] ?? "";
    else if (arg === "--apply") parsed.apply = true;
    else if (arg === "--skip-ocr") parsed.skipOcr = true;
    else if (arg === "--clamp-seasonal-orig-max-100") parsed.clampSeasonalOrigMax100 = true;
    else fail(`Unknown argument: ${arg}`);
  }
  return parsed;
}

function resolveExistingInputDir(root, fullKey, baseKey) {
  const full = path.join(root, "data_files", "data_to_process", fullKey);
  if (existsSync(full)) return full;
  return path.join(root, "data_files", "data_to_process", baseKey);
}

/**
 * If `Итоговые результаты.txt` exists in the contest folder, rename it to `<contest>_raw.txt`
 * when `--apply` is used so later runs and tooling see the standard name.
 * Dry run does not rename; `readRawText` still reads the Russian filename if `_raw.txt` is missing.
 */
function maybeRenameFinalResultsTxt(inputDirValue, prefixValue, apply) {
  const from = path.join(inputDirValue, FINAL_RESULTS_TXT);
  const to = path.join(inputDirValue, `${prefixValue}_raw.txt`);
  if (!existsSync(from)) return;
  if (existsSync(to)) {
    notes.push(
      `"Итоговые результаты.txt" is present but ${prefixValue}_raw.txt already exists; not renaming. Remove or rename one of them if this is wrong.`
    );
    return;
  }
  if (!apply) {
    notes.push(
      `Using "Итоговые результаты.txt" as raw input (dry run). Run with --apply to rename it to ${prefixValue}_raw.txt.`
    );
    return;
  }
  renameSync(from, to);
  notes.push(`Renamed "Итоговые результаты.txt" to ${prefixValue}_raw.txt.`);
}

function readRawText(inputDirValue, outputDirValue, prefixValue, rawPrefixValue = prefixValue) {
  const candidates = [
    path.join(inputDirValue, `${prefixValue}_raw.txt`),
    path.join(inputDirValue, `${rawPrefixValue}_raw.txt`),
    path.join(inputDirValue, FINAL_RESULTS_TXT),
    path.join(outputDirValue, `${prefixValue}_raw.txt`),
    path.join(outputDirValue, `${rawPrefixValue}_raw.txt`)
  ];
  const found = candidates.find((candidate) => existsSync(candidate));
  if (!found) {
    notes.push(`No raw text file found for ${prefixValue}; placement and award parsing may be incomplete.`);
    return "";
  }
  const buffer = readFileSync(found);
  return new TextDecoder("windows-1251").decode(buffer);
}

function parseRawText(text, context = {}) {
  const placements = [];
  const awards = { biggestOdds: [] };
  const lines = text.split(/\r?\n/).map((value) => value.trim()).filter(Boolean);
  const hasMonthlyOrFinalSections = lines.some((line) => classifyRawSection(line));
  let currentSection = hasMonthlyOrFinalSections ? "" : "seasonal";

  for (const line of lines) {
    const section = classifyRawSection(line);
    if (section) {
      currentSection = section;
      continue;
    }

    if (context.isMonthly) {
      if (currentSection !== `monthly:${context.monthlyNumber}`) continue;
      const placement = parseMonthlyPlacementLine(line);
      if (placement) placements.push(placement);
      continue;
    }

    if (hasMonthlyOrFinalSections && currentSection !== "seasonal-final") continue;

    const placement = parsePlacementLine(line);
    if (placement) {
      placements.push(placement);
      continue;
    }

    const award = parseAwardLine(line);
    if (award?.type === "winningStreak") awards.winningStreak = award.row;
    if (award?.type === "biggestOdds") awards.biggestOdds.push(...award.rows);
  }
  return { placements, awards };
}

function classifyRawSection(line) {
  const monthly = line.match(/Результаты\s+([12])-го\s+месячного\s+конкурса/i);
  if (monthly) return `monthly:${monthly[1]}`;
  if (/Итоговые\s+результаты\s+конкурса/i.test(line)) return "seasonal-final";
  return "";
}

function parseMonthlyPlacementLine(line) {
  const match = line.match(
    /^(\d+)\.\s+(\S+)\s+(\d+(?:[.,]\d+)?)\s+([+-]?\d+(?:[.,]\d+)?)\s+([+-]?\d+(?:[.,]\d+)?)\s*%\s*ROI\b(.*)$/i
  );
  if (!match) return null;

  const [, place, nickname, betsCount, units, roi, tail] = match;
  const normalizedBetsCount = normalizeNumber(betsCount);
  const monthlyNonParticipant = /не\s+участвовал/i.test(tail);
  if (Number(normalizedBetsCount) < 30 || monthlyNonParticipant) return null;

  return {
    nickname: nickname.trim(),
    place: place.trim(),
    roi: normalizeNumber(roi),
    explicitCount: normalizedBetsCount,
    units: normalizeNumber(units),
    monthlyNonParticipant
  };
}

function parsePlacementLine(line) {
  const match = line.match(/^(\d+)\s+(?:место|place)\.?\s+(.+?)\s+-\s+(.+)$/i);
  const numbered = !match ? line.match(/^(\d+)\.\s+(\S+)\s+(.+)$/) : null;
  const m = match ?? numbered;
  if (!m) return null;
  const [, place, nickname, tail] = m;
  const roi = firstNonEmpty(
    findNumberAfter(tail, /ROI\s*:/i),
    findPercentNumber(tail)
  );
  const explicitCount = firstNonEmpty(
    findNumberAfter(tail, /Predictions\s*:/i),
    findFirstNumber(tail.match(/\((\d+(?:[.,]\d+)?)\s*(?:став|bet)/i)?.[1] ?? "")
  );
  const inlineStats = parseInlineStats(tail);
  return {
    nickname: nickname.trim(),
    place: place.trim(),
    roi,
    explicitCount,
    incomplete: /не\s+доиграл|incomplete|disqual/i.test(tail),
    ...inlineStats
  };
}

function parseInlineStats(text) {
  const predictions = findNumberAfter(text, /Predictions\s*:/i);
  const won = findNumberAfter(text, /Won\s*:/i);
  const lost = findNumberAfter(text, /Lost\s*:/i);
  const units = findNumberAfter(text, /\+\/-\s*:/i);
  if (!predictions && !won && !lost && !units) return {};
  return { predictions, won, lost, units };
}

function splitAwardNicknameList(segment) {
  return segment
    .split(/\s*,\s*|\s+и\s+/i)
    .map((part) => part.trim())
    .filter(Boolean);
}

function extractStreakAvgOdds(line) {
  const inParens = line.match(/\([\s\S]*?(?:ср\.?\s*)?(?:коф|коэф|кофф)\.?\s*([\d.,]+)/i);
  if (inParens) return normalizeNumber(inParens[1]);
  const loose = line.match(/(?:ср\.?\s*)?(?:коф|коэф|кофф)\.?\s*([\d.,]+)/i);
  return loose ? normalizeNumber(loose[1]) : "";
}

function parseAwardLine(line) {
  const lower = line.toLowerCase();
  const isStreak = /сер(и|і)я|streak|consecutive/.test(lower);
  const isOdds =
    /коэффициент|коеф|кофф|коф\.|odds|odd|coefficient/i.test(lower) && !/roi/.test(lower);
  if (!isStreak && !isOdds) return null;

  const parts = line.split(/\s+-\s+/).map((part) => part.trim()).filter(Boolean);
  if (parts.length < 3) return null;
  const nicknameSegment = parts[1];
  const value = findFirstNumber(parts.slice(2).join(" "));
  if (!nicknameSegment || !value) return null;

  if (isStreak) {
    const nicknames = splitAwardNicknameList(nicknameSegment);
    const nickname = nicknames[0] ?? nicknameSegment;
    const strick_avg_odds = extractStreakAvgOdds(line);
    return {
      type: "winningStreak",
      row: { nickname, strick_length: value, strick_avg_odds }
    };
  }

  const nicknames = splitAwardNicknameList(nicknameSegment);
  if (nicknames.length === 0) return null;
  return {
    type: "biggestOdds",
    rows: nicknames.map((nickname) => ({ nickname, user_pick_value: value }))
  };
}

function ensureOcrJsonSidecars(inputDirValue, parsedOptions) {
  const files = readdirSync(inputDirValue);
  const imageFiles = files.filter((file) => /\.(jpe?g|png)$/i.test(file));
  const jsonFilesValue = files.filter((file) => /\.json$/i.test(file)).map((file) => path.join(inputDirValue, file));

  for (const image of imageFiles) {
    const parsed = path.parse(image);
    const jsonPath = path.join(inputDirValue, `${parsed.name}.json`);
    if (existsSync(jsonPath)) continue;
    if (parsedOptions.skipOcr || !parsedOptions.apply) {
      notes.push(`Missing OCR JSON for ${image}; run with --apply without --skip-ocr to generate it.`);
      continue;
    }
    const result = spawnSync(
      "npm",
      ["run", "ocr", "--", "--input", path.join(inputDirValue, image), "--output", jsonPath],
      { cwd: repoRoot, encoding: "utf8", shell: process.platform === "win32" }
    );
    if (result.status !== 0) {
      fail(`OCR failed for ${image}:\n${result.stderr || result.stdout}`);
    }
    jsonFilesValue.push(jsonPath);
  }
  return [...new Set(jsonFilesValue.concat(
    readdirSync(inputDirValue).filter((file) => /\.json$/i.test(file)).map((file) => path.join(inputDirValue, file))
  ))];
}

function parseOcrJsonFiles(files, context = {}) {
  const byNickname = new Map();
  const expectedNames = context.expectedNames;
  for (const file of files) {
    const nickname = path.parse(file).name;
    const entries = JSON.parse(readFileSync(file, "utf8"));
    const descriptions = entries.map((entry) => String(entry.description ?? ""));
    const stats = context.monthlyMonthLabel
      ? parseOcrMonth(descriptions, context.monthlyMonthLabel)
      : parseOcrTotal(descriptions);
    if (stats) byNickname.set(normalizeName(nickname), { nickname, ...stats });
    else if (context.monthlyMonthLabel && (!expectedNames || expectedNames.has(normalizeName(nickname)))) {
      notes.push(
        `Could not parse ${context.monthlyMonthLabel} stats from OCR JSON: ${path.relative(repoRoot, file)}`
      );
    } else {
      notes.push(`Could not parse Total stats from OCR JSON: ${path.relative(repoRoot, file)}`);
    }
  }
  return byNickname;
}

function buildMonthlyArtifactsForSeason(context) {
  const artifacts = [];
  for (const monthNumber of [1, 2]) {
    const monthlyKey = `${context.folderKey}_mon_${monthNumber}`;
    const monthlyMonthLabel = calendarMonthLabel(context.folderKey, monthNumber);
    if (!monthlyMonthLabel) continue;

    const rawMonthly = parseRawText(context.rawText, { isMonthly: true, monthlyNumber: monthNumber });
    if (rawMonthly.placements.length === 0) {
      context.notes.push(`${monthlyKey}: no embedded monthly rows were parsed.`);
      continue;
    }

    const expectedNames = new Set(rawMonthly.placements.map((placement) => normalizeName(placement.nickname)));
    const ocrByNicknameForMonth = parseOcrJsonFiles(context.jsonFiles, { monthlyMonthLabel, expectedNames });
    const monthlyRows = buildGeneralRows(rawMonthly.placements, ocrByNicknameForMonth, {
      isMonthly: true,
      notes: context.notes,
      contestKey: monthlyKey,
      monthlyMonthLabel,
      clampSeasonalOrigMax100: context.clampSeasonalOrigMax100
    });
    const generalPathValue = path.join(context.outputDir, `${monthlyKey}_cr_general.csv`);
    const generalCsvValue = normalizeGeneralCsvText(mergeCsv(
      generalPathValue,
      GENERAL_HEADER,
      monthlyRows,
      "nickname",
      { replaceRows: true }
    ), {
      contestKey: monthlyKey,
      isMonthly: true,
      clampSeasonalOrigMax100: context.clampSeasonalOrigMax100,
      notes: context.notes
    });

    artifacts.push({
      contest: monthlyKey,
      monthLabel: monthlyMonthLabel,
      rows: monthlyRows,
      generalPath: generalPathValue,
      generalCsv: generalCsvValue
    });
  }
  return artifacts;
}

function parseOcrTotal(descriptions) {
  for (let index = 0; index < descriptions.length; index += 1) {
    if (descriptions[index] !== "Total") continue;
    const stats = parseOcrStatsAfter(descriptions, index);
    if (stats) return stats;
  }
  return null;
}

function parseOcrMonth(descriptions, monthLabel) {
  for (let index = 0; index < descriptions.length; index += 1) {
    if (descriptions[index] !== monthLabel) continue;
    const stats = parseOcrStatsAfter(descriptions, index);
    if (stats) return stats;
  }
  return null;
}

function parseOcrStatsAfter(descriptions, index) {
  const next = descriptions.slice(index + 1, index + 14);
  if (!isNumericToken(next[0])) return null;
  const numbers = [];
  for (const token of next) {
    if (isNumericToken(token)) {
      numbers.push(normalizeNumber(token));
      if (numbers.length >= 5) break;
      continue;
    }
    if (String(token).trim() === "%") continue;
    break;
  }
  if (numbers.length < 4) return null;
  return {
    predictions: numbers[0],
    won: numbers[1],
    lost: numbers[2],
    units: numbers[3],
    ocrRoi: numbers[4] ?? ""
  };
}

function buildGeneralRows(placements, ocrByName, context) {
  const participantCount = placements.length;
  return placements.map((placement) => {
    const ocr = ocrByName.get(normalizeName(placement.nickname));
    const rawOrig = firstNonEmpty(placement.explicitCount, placement.predictions, ocr?.predictions);
    const orig = context.isMonthly ? rawOrig : defaultOrigBetsCount(rawOrig);
    const finalCount = context.isMonthly ? orig : "100";
    const roi = normalizeRoi(firstNonEmpty(placement.roi, ocr?.ocrRoi));
    const deriveUnitsFromRoi = !context.isMonthly && context.contestKey !== "2012_autumn";

    if (context.isMonthly) {
      if (!ocr) {
        context.notes.push(
          `${placement.nickname}: OCR ${context.monthlyMonthLabel} stats are missing; raw monthly values kept.`
        );
      }
    } else if (orig) {
      const numericOrig = Number(orig);
      const willClamp = context.clampSeasonalOrigMax100 && numericOrig > 100;
      if (numericOrig !== 100 && !willClamp) {
        context.notes.push(
          `${placement.nickname}: seasonal orig_bets_count is not 100 (${orig}); source requires review.`
        );
      }
    }
    if (placement.roi && ocr?.ocrRoi && Number(normalizeRoi(placement.roi)) !== Number(normalizeRoi(ocr.ocrRoi))) {
      context.notes.push(`${placement.nickname}: raw ROI (${normalizeRoi(placement.roi)}) differs from OCR ROI (${normalizeRoi(ocr.ocrRoi)}); raw ROI kept.`);
    }
    if (context.isMonthly && orig && ocr?.predictions && Number(orig) !== Number(ocr.predictions)) {
      const source = context.isMonthly ? context.monthlyMonthLabel : "Total";
      context.notes.push(`${placement.nickname}: raw Predictions (${orig}) differs from OCR ${source} Predictions (${ocr.predictions}).`);
    } else if (!context.isMonthly && placement.predictions && ocr?.predictions && Number(placement.predictions) !== Number(ocr.predictions)) {
      context.notes.push(`${placement.nickname}: raw Predictions (${placement.predictions}) differs from OCR Total Predictions (${ocr.predictions}).`);
    }
    if (placement.won && ocr?.won && Number(normalizeNumber(placement.won)) !== Number(normalizeNumber(ocr.won))) {
      context.notes.push(`${placement.nickname}: raw Won (${placement.won}) differs from OCR Won (${ocr.won}).`);
    }
    if (placement.lost && ocr?.lost && Number(normalizeNumber(placement.lost)) !== Number(normalizeNumber(ocr.lost))) {
      context.notes.push(`${placement.nickname}: raw Lost (${placement.lost}) differs from OCR Lost (${ocr.lost}).`);
    }

    const derivedWon = deriveWonFromRoi(roi);
    if (!context.isMonthly && !placement.won && derivedWon && ocr?.won && Number(derivedWon) !== Number(ocr.won)) {
      context.notes.push(
        `${placement.nickname}: derived Won from ROI (${derivedWon}) differs from OCR Won (${ocr.won}); derived Won kept.`
      );
    }
    const won = context.isMonthly ? firstNonEmpty(placement.won, ocr?.won) : firstNonEmpty(placement.won, derivedWon, ocr?.won);

    const derivedUnits = deriveUnitsFromRoi ? roi : "";
    if (deriveUnitsFromRoi && roi && ocr?.units && Number(roi) !== Number(ocr.units)) {
      context.notes.push(
        `${placement.nickname}: derived Units from ROI (${roi}) differs from OCR Units (${ocr.units}); derived Units kept.`
      );
    }
    if (context.isMonthly && placement.units && ocr?.units && Number(placement.units) !== Number(ocr.units)) {
      context.notes.push(
        `${placement.nickname}: raw Units (${placement.units}) differs from OCR ${context.monthlyMonthLabel} Units (${ocr.units}); raw Units kept.`
      );
    }
    const units = context.isMonthly ? placement.units : (deriveUnitsFromRoi ? derivedUnits : firstNonEmpty(placement.units, ocr?.units));
    return {
      annual_points: context.isMonthly ? "" : String(annualPoints(Number(placement.place), participantCount)),
      nickname: placement.nickname,
      place: placement.place,
      final_bets_count: finalCount,
      orig_bets_count: orig,
      won,
      lost: firstNonEmpty(placement.lost, ocr?.lost),
      units,
      roi
    };
  });
}

function annualPoints(place, total) {
  const fromBottom = total - place + 1;
  if (place === 1) return total + 3;
  if (place === 2) return total + 1;
  if (place === 3) return total - 1;
  return fromBottom;
}

function mergeCsv(filePath, defaultHeader, updates, keyColumn, options = {}) {
  const existing = readCsv(filePath, defaultHeader);
  const keyIndex = existing.header.indexOf(keyColumn);
  const rowMap = new Map(existing.rows.map((row) => [normalizeName(row[keyIndex] ?? ""), row]));

  for (const update of updates) {
    const key = normalizeName(update[keyColumn] ?? "");
    if (!key) continue;
    const isNewRow = !rowMap.has(key);
    const row = rowMap.get(key) ?? existing.header.map(() => "");
    for (const [column, value] of Object.entries(update)) {
      const columnIndex = existing.header.indexOf(column);
      if (columnIndex >= 0 && (isNewRow || String(value ?? "").length > 0)) {
        row[columnIndex] = value ?? "";
      }
    }
    rowMap.set(key, row);
  }

  if (options.replaceRows) {
    return [existing.header.join(","), ...updates.map((update) => {
      const key = normalizeName(update[keyColumn] ?? "");
      return rowMap.get(key) ?? existing.header.map(() => "");
    }).map((row) => row.join(","))].join("\n") + "\n";
  }

  const orderedRows = existing.rows.map((row) => rowMap.get(normalizeName(row[keyIndex] ?? "")) ?? row);
  for (const [key, row] of rowMap.entries()) {
    if (!existing.rows.some((existingRow) => normalizeName(existingRow[keyIndex] ?? "") === key)) {
      orderedRows.push(row);
    }
  }
  return [existing.header.join(","), ...orderedRows.map((row) => row.join(","))].join("\n") + "\n";
}

function normalizeGeneralCsvText(csvText, options = {}) {
  const contestKey = String(options.contestKey ?? "");
  const isMonthly = Boolean(options.isMonthly);
  const clampSeasonalOrigMax100 = Boolean(options.clampSeasonalOrigMax100);
  const notes = options.notes;
  const lines = String(csvText ?? "").split(/\r?\n/);
  const header = lines[0]?.split(",") ?? [];
  const roiIndex = header.indexOf("roi");
  const origIndex = header.indexOf("orig_bets_count");
  const wonIndex = header.indexOf("won");
  const unitsIndex = header.indexOf("units");
  const nicknameIndex = header.indexOf("nickname");
  if (roiIndex < 0 && origIndex < 0 && wonIndex < 0) return csvText;

  const out = [lines[0]];
  for (const line of lines.slice(1)) {
    if (line.length === 0) continue;
    const cols = line.split(",");

    const roi = normalizeRoi(cols[roiIndex] ?? "");
    if (roiIndex >= 0) cols[roiIndex] = roi;

    if (origIndex >= 0) {
      let origVal = cols[origIndex] ?? "";
      if (
        clampSeasonalOrigMax100 &&
        !isMonthly &&
        nicknameIndex >= 0 &&
        notes &&
        Number(origVal) > 100
      ) {
        const prev = String(origVal).trim();
        notes.push(
          `${cols[nicknameIndex]}: orig_bets_count clamped from ${prev} to 100 (--clamp-seasonal-orig-max-100).`
        );
        origVal = "100";
      }
      cols[origIndex] = isMonthly ? String(origVal ?? "").trim() : defaultOrigBetsCount(origVal);
    }

    if (!isMonthly && wonIndex >= 0) {
      const won = String(cols[wonIndex] ?? "");
      if (!won && roi) cols[wonIndex] = deriveWonFromRoi(roi);
    }

    if (!isMonthly && unitsIndex >= 0 && contestKey !== "2012_autumn") {
      cols[unitsIndex] = roi;
    }

    out.push(cols.join(","));
  }
  return out.join("\n") + "\n";
}

function calendarMonthLabel(contestKey, monthNumber) {
  const match = String(contestKey ?? "").match(/^(\d{4})_(spring|summer|autumn|winter)$/i);
  if (!match || !monthNumber) return "";
  const year = Number(match[1]);
  const season = match[2].toLowerCase();
  const monthBySeason = {
    spring: [3, 4],
    summer: [6, 7],
    autumn: [9, 10],
    winter: [12, 1]
  };
  const month = monthBySeason[season]?.[monthNumber - 1];
  if (!month) return "";
  const labelYear = season === "winter" && monthNumber === 2 ? year + 1 : year;
  return `${String(month).padStart(2, "0")}/${labelYear}`;
}

function readCsv(filePath, defaultHeader) {
  if (!existsSync(filePath)) return { header: defaultHeader, rows: [] };
  const lines = readFileSync(filePath, "utf8").split(/\r?\n/).filter((line) => line.length > 0);
  return {
    header: lines[0].split(","),
    rows: lines.slice(1).map((line) => line.split(","))
  };
}

function findNumberAfter(text, labelPattern) {
  const match = text.match(new RegExp(`${labelPattern.source}\\s*([+-]?\\d+(?:[.,]\\d+)?)`, labelPattern.flags));
  return normalizeNumber(match?.[1] ?? "");
}

function findFirstNumber(text) {
  const match = text.match(/[+-]?\d+(?:[.,]\d+)?/);
  return normalizeNumber(match?.[0] ?? "");
}

function findPercentNumber(text) {
  // Raw result lines often use "+11.3%" instead of an explicit "ROI:" label.
  // AGENTS.md requires storing ROI as a numeric percentage without the "%" sign.
  const match = String(text ?? "").match(/([+-]?\d+(?:[.,]\d+)?)\s*%/);
  return normalizeNumber(match?.[1] ?? "");
}

function isNumericToken(value) {
  return /^[+-]?\d+(?:[.,]\d+)?$/.test(String(value ?? "").trim());
}

function normalizeNumber(value) {
  return value ? String(value).replace(",", ".") : "";
}

function normalizeRoi(value) {
  const normalized = normalizeNumber(String(value ?? "").trim());
  return normalized.startsWith("+") ? normalized.slice(1) : normalized;
}

function normalizeName(value) {
  return String(value ?? "").trim().toLowerCase();
}

function firstNonEmpty(...values) {
  for (const value of values) {
    if (value !== undefined && value !== null && String(value).length > 0) return String(value);
  }
  return "";
}

function defaultOrigBetsCount(value) {
  const v = String(value ?? "").trim();
  return v.length > 0 ? v : "100";
}

function deriveWonFromRoi(roiValue) {
  const roi = normalizeRoi(roiValue);
  if (!roi) return "";
  const roiNumber = Number(roi);
  if (!Number.isFinite(roiNumber)) return "";

  const decimals = roi.includes(".") ? roi.split(".")[1].length : 0;
  const total = 100 + roiNumber;
  return decimals > 0 ? total.toFixed(decimals) : String(total);
}

function printSummary(summary) {
  console.log(summary.apply ? "Applied contest result updates." : "Dry run only; no files were changed.");
  console.log(`Contest: ${summary.contest}`);
  console.log(`Input: ${path.relative(repoRoot, summary.inputDir)}`);
  console.log(`Output: ${path.relative(repoRoot, summary.outputDir)}`);
  console.log("\nGeneral rows:");
  for (const row of summary.rows) console.log(JSON.stringify(row));
  console.log("\nAwards:");
  console.log(JSON.stringify(summary.awards, null, 2));
  if (!summary.apply) {
    console.log("\nGenerated cr_general CSV:");
    console.log(summary.generatedCsv.general.trimEnd());
    if (summary.generatedCsv.odds) {
      console.log("\nGenerated cr_biggest_odds CSV:");
      console.log(summary.generatedCsv.odds.trimEnd());
    }
    if (summary.generatedCsv.streak) {
      console.log("\nGenerated cr_winning_streak CSV:");
      console.log(summary.generatedCsv.streak.trimEnd());
    }
    if (summary.monthlyArtifacts.length > 0) {
      for (const artifact of summary.monthlyArtifacts) {
        console.log(`\nGenerated ${artifact.contest}_cr_general CSV (${artifact.monthLabel}):`);
        console.log(artifact.generalCsv.trimEnd());
      }
    }
  }
  console.log("\nOCR JSON files:");
  for (const file of summary.jsonFiles) console.log(path.relative(repoRoot, file));
  if (summary.notes.length > 0) {
    console.log("\nNotifications:");
    for (const note of [...new Set(summary.notes)]) console.log(`- ${note}`);
  }
}

function fail(message) {
  console.error(message);
  process.exit(1);
}
