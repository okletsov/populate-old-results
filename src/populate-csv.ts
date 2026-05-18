import fs from "fs";
import * as mariadb from "mariadb";
import { getDbConfig } from "./config/env.js";

// Simple CSV parser
function parseCSV(content: string): { headers: string[]; records: Record<string, string>[] } {
  const lines = content.trim().split("\n");
  const headers = lines[0].split(",");
  const records: Record<string, string>[] = [];
  
  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(",");
    const record: Record<string, string> = {};
    headers.forEach((header, idx) => {
      record[header] = values[idx] || "";
    });
    records.push(record);
  }
  
  return { headers, records };
}

// Simple CSV stringifier
function stringifyCSV(headers: string[], records: Record<string, string>[]): string {
  const lines: string[] = [headers.join(",")];
  
  for (const record of records) {
    const values = headers.map(header => record[header] || "");
    lines.push(values.join(","));
  }
  
  return lines.join("\n");
}

async function main() {
  const dbConfig = getDbConfig();
  console.log("Database config:", dbConfig);
  
  // Read the CSV file
  const csvPath = "data_files/contest_results/2013_autumn/2013_autumn_cr_general.csv";
  const csvContent = fs.readFileSync(csvPath, "utf-8");
  const { headers, records } = parseCSV(csvContent);

  // Create database connection
  const connection = await mariadb.createConnection(dbConfig);

  try {
    // Get contest_id for 2013 autumn seasonal
    const contestResult = await connection.query(
      `SELECT id FROM contest WHERE year = ? AND season = ? AND type = ?`,
      ["2013", "autumn", "seasonal"]
    );
    
    if (contestResult.length === 0) {
      throw new Error("Contest not found for 2013 autumn");
    }
    
    const contestId = contestResult[0].id;
    console.log(`Found contest_id: ${contestId}`);

    // Process each row
    for (const record of records) {
      const nickname = record.nickname;
      
      // Get user_id for this nickname
      const userResult = await connection.query(
        `SELECT user_id FROM user_nickname WHERE nickname = ?`,
        [nickname]
      );
      
      if (userResult.length > 0) {
        record.user_id = userResult[0].user_id.toString();
      } else {
        console.warn(`No user_id found for nickname: ${nickname}`);
      }
      
      // Set contest_id
      record.contest_id = contestId.toString();
      
      // Keep active_days empty
      record.active_days = "";
    }

    // Write the CSV file back
    const updatedCsv = stringifyCSV(headers, records);

    fs.writeFileSync(csvPath, updatedCsv, "utf-8");
    console.log("CSV file updated successfully");

  } finally {
    await connection.end();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
