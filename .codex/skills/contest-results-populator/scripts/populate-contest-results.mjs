#!/usr/bin/env node
import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
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

const options = parseArgs(process.argv.slice(2));
if (!options.contest) {
  fail("Usage: node populate-contest-results.mjs --contest <contest_key> [--apply] [--skip-ocr]");
}

const repoRoot = process.cwd();
const contest = options.contest;
const monthlyMatch = contest.match(/^(\d{4}_[a-z]+)_mon_\d+$/i);
const folderKey = monthlyMatch ? monthlyMatch[1] : contest;
const isMonthly = Boolean(monthlyMatch);
const inputDir = resolveExistingInputDir(repoRoot, contest, folderKey);
const outputDir = path.join(repoRoot, "data_files", "contest_results", folderKey);
const prefix = contest;
const notes = [];

if (!existsSync(inputDir)) {
  fail(`Input directory does not exist: ${inputDir}`);
}
if (!existsSync(outputDir) && options.apply) {
  mkdirSync(outputDir, { recursive: true });
}

const rawText = readRawText(inputDir, outputDir, prefix);
const raw = parseRawText(rawText);

const jsonFiles = ensureOcrJsonSidecars(inputDir, options);
const ocrByNickname = parseOcrJsonFiles(jsonFiles);
const rows = buildGeneralRows(raw.placements, ocrByNickname, { isMonthly, notes });
const awards = raw.awards;

const generalPath = path.join(outputDir, `${prefix}_cr_general.csv`);
const oddsPath = path.join(outputDir, `${prefix}_cr_biggest_odds.csv`);
const streakPath = path.join(outputDir, `${prefix}_cr_winning_streak.csv`);

const generalCsv = normalizeGeneralCsvText(mergeCsv(generalPath, GENERAL_HEADER, rows, "nickname"));
const oddsCsv = mergeCsv(
  oddsPath,
  BIGGEST_ODDS_HEADER,
  awards.biggestOdds ? [awards.biggestOdds] : [],
  "nickname"
);
const streakCsv = mergeCsv(
  streakPath,
  WINNING_STREAK_HEADER,
  awards.winningStreak ? [awards.winningStreak] : [],
  "nickname"
);

if (options.apply) {
  writeFileSync(generalPath, generalCsv, "utf8");
  writeFileSync(oddsPath, oddsCsv, "utf8");
  writeFileSync(streakPath, streakCsv, "utf8");
}

printSummary({
  apply: options.apply,
  contest,
  inputDir,
  outputDir,
  jsonFiles,
  rows,
  awards,
  notes
});

function parseArgs(args) {
  const parsed = { apply: false, skipOcr: false, contest: "" };
  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];
    if (arg === "--contest") parsed.contest = args[++i] ?? "";
    else if (arg === "--apply") parsed.apply = true;
    else if (arg === "--skip-ocr") parsed.skipOcr = true;
    else fail(`Unknown argument: ${arg}`);
  }
  return parsed;
}

function resolveExistingInputDir(root, fullKey, baseKey) {
  const full = path.join(root, "data_files", "data_to_process", fullKey);
  if (existsSync(full)) return full;
  return path.join(root, "data_files", "data_to_process", baseKey);
}

function readRawText(inputDirValue, outputDirValue, prefixValue) {
  const candidates = [
    path.join(inputDirValue, `${prefixValue}_raw.txt`),
    path.join(outputDirValue, `${prefixValue}_raw.txt`)
  ];
  const found = candidates.find((candidate) => existsSync(candidate));
  if (!found) {
    notes.push(`No raw text file found for ${prefixValue}; placement and award parsing may be incomplete.`);
    return "";
  }
  const buffer = readFileSync(found);
  return new TextDecoder("windows-1251").decode(buffer);
}

function parseRawText(text) {
  const placements = [];
  const awards = {};
  for (const line of text.split(/\r?\n/).map((value) => value.trim()).filter(Boolean)) {
    const placement = parsePlacementLine(line);
    if (placement) {
      placements.push(placement);
      continue;
    }

    const award = parseAwardLine(line);
    if (award?.type === "winningStreak") awards.winningStreak = award.row;
    if (award?.type === "biggestOdds") awards.biggestOdds = award.row;
  }
  return { placements, awards };
}

function parsePlacementLine(line) {
  const match = line.match(/^(\d+)\s+(?:место|place)\.?\s+(.+?)\s+-\s+(.+)$/i);
  if (!match) return null;
  const [, place, nickname, tail] = match;
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

function parseAwardLine(line) {
  const lower = line.toLowerCase();
  const isStreak = /сер(и|і)я|streak|consecutive/.test(lower);
  const isOdds = /коэффициент|коеф|odds|odd|coefficient/.test(lower) && !/roi/.test(lower);
  if (!isStreak && !isOdds) return null;

  const parts = line.split(/\s+-\s+/).map((part) => part.trim()).filter(Boolean);
  if (parts.length < 3) return null;
  const nickname = parts[1];
  const value = findFirstNumber(parts.slice(2).join(" "));
  if (!nickname || !value) return null;

  if (isStreak) {
    return {
      type: "winningStreak",
      row: { nickname, strick_length: value, strick_avg_odds: "" }
    };
  }
  return {
    type: "biggestOdds",
    row: { nickname, user_pick_value: value }
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

function parseOcrJsonFiles(files) {
  const byNickname = new Map();
  for (const file of files) {
    const nickname = path.parse(file).name;
    const entries = JSON.parse(readFileSync(file, "utf8"));
    const descriptions = entries.map((entry) => String(entry.description ?? ""));
    const stats = parseOcrTotal(descriptions);
    if (stats) byNickname.set(normalizeName(nickname), { nickname, ...stats });
    else notes.push(`Could not parse Total stats from OCR JSON: ${path.relative(repoRoot, file)}`);
  }
  return byNickname;
}

function parseOcrTotal(descriptions) {
  for (let index = 0; index < descriptions.length; index += 1) {
    if (descriptions[index] !== "Total") continue;
    const next = descriptions.slice(index + 1, index + 12);
    if (!isNumericToken(next[0])) continue;
    const numbers = [];
    for (const token of next) {
      if (isNumericToken(token)) {
        numbers.push(normalizeNumber(token));
        continue;
      }
      if (String(token).trim() === "%") continue;
      break;
    }
    if (numbers.length >= 4) {
      return {
        predictions: numbers[0],
        won: numbers[1],
        lost: numbers[2],
        units: numbers[3],
        ocrRoi: numbers[4] ?? ""
      };
    }
  }
  return null;
}

function buildGeneralRows(placements, ocrByName, context) {
  const participantCount = placements.length;
  return placements.map((placement) => {
    const ocr = ocrByName.get(normalizeName(placement.nickname));
    const orig = defaultOrigBetsCount(firstNonEmpty(placement.explicitCount, placement.predictions, ocr?.predictions));
    const finalCount = context.isMonthly ? orig : "100";
    const roi = normalizeRoi(firstNonEmpty(placement.roi, ocr?.ocrRoi));

    if (!context.isMonthly && orig) {
      const numericOrig = Number(orig);
      if (numericOrig !== 100) {
        context.notes.push(`${placement.nickname}: seasonal orig_bets_count is not 100 (${orig}).`);
      }
      if (numericOrig > 100) {
        context.notes.push(`${placement.nickname}: seasonal orig_bets_count is above 100 (${orig}); source requires review.`);
      }
    }
    if (placement.roi && ocr?.ocrRoi && Number(normalizeRoi(placement.roi)) !== Number(normalizeRoi(ocr.ocrRoi))) {
      context.notes.push(`${placement.nickname}: raw ROI (${normalizeRoi(placement.roi)}) differs from OCR ROI (${normalizeRoi(ocr.ocrRoi)}); raw ROI kept.`);
    }
    if (placement.predictions && ocr?.predictions && Number(placement.predictions) !== Number(ocr.predictions)) {
      context.notes.push(`${placement.nickname}: raw Predictions (${placement.predictions}) differs from OCR Total Predictions (${ocr.predictions}).`);
    }

    const won = firstNonEmpty(placement.won, ocr?.won);
    return {
      annual_points: String(annualPoints(Number(placement.place), participantCount)),
      nickname: placement.nickname,
      place: placement.place,
      final_bets_count: finalCount,
      orig_bets_count: orig,
      won: firstNonEmpty(won, deriveWonFromRoi(roi)),
      lost: firstNonEmpty(placement.lost, ocr?.lost),
      units: firstNonEmpty(placement.units, ocr?.units),
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

function mergeCsv(filePath, defaultHeader, updates, keyColumn) {
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

  const orderedRows = existing.rows.map((row) => rowMap.get(normalizeName(row[keyIndex] ?? "")) ?? row);
  for (const [key, row] of rowMap.entries()) {
    if (!existing.rows.some((existingRow) => normalizeName(existingRow[keyIndex] ?? "") === key)) {
      orderedRows.push(row);
    }
  }
  return [existing.header.join(","), ...orderedRows.map((row) => row.join(","))].join("\n") + "\n";
}

function normalizeGeneralCsvText(csvText) {
  const lines = String(csvText ?? "").split(/\r?\n/);
  const header = lines[0]?.split(",") ?? [];
  const roiIndex = header.indexOf("roi");
  const origIndex = header.indexOf("orig_bets_count");
  const wonIndex = header.indexOf("won");
  if (roiIndex < 0 && origIndex < 0 && wonIndex < 0) return csvText;

  const out = [lines[0]];
  for (const line of lines.slice(1)) {
    if (line.length === 0) continue;
    const cols = line.split(",");

    const roi = normalizeRoi(cols[roiIndex] ?? "");
    if (roiIndex >= 0) cols[roiIndex] = roi;

    if (origIndex >= 0) {
      cols[origIndex] = defaultOrigBetsCount(cols[origIndex] ?? "");
    }

    if (wonIndex >= 0) {
      const won = String(cols[wonIndex] ?? "");
      if (!won && roi) cols[wonIndex] = deriveWonFromRoi(roi);
    }

    out.push(cols.join(","));
  }
  return out.join("\n") + "\n";
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
