import { Command } from "commander";
import { getDbConfig, getVisionConfig } from "./config/env.js";
import { createPool, closePool } from "./db/mariadbClient.js";
import { executeReadOnlySelect } from "./db/runSelect.js";
import { getInformationSchemaSnapshot } from "./db/schemaIntrospector.js";
import { convertImageToJson } from "./ocr/visionOcr.js";

const program = new Command();

program
  .name("populate-old-results")
  .description("Connect to MariaDB and read information_schema for the configured database")
  .version("0.1.0");

program
  .command("schema")
  .description(
    "Connect using DB_* from .env and print tables + columns from information_schema"
  )
  .action(async () => {
    const dbConfig = getDbConfig();
    const pool = createPool(dbConfig);

    try {
      const snapshot = await getInformationSchemaSnapshot(pool, dbConfig.DB_NAME);
      console.log(JSON.stringify(snapshot, null, 2));
    } finally {
      await closePool();
    }
  });

program
  .command("query")
  .description(
    "Run a single read-only SELECT (or WITH ... SELECT) using DB_* from .env"
  )
  .requiredOption("--sql <sql>", "SQL text")
  .action(async (options) => {
    const dbConfig = getDbConfig();
    const pool = createPool(dbConfig);

    try {
      const rows = await executeReadOnlySelect(pool, String(options.sql));
      console.log(JSON.stringify(rows, null, 2));
    } finally {
      await closePool();
    }
  });

program
  .command("ocr")
  .description("Extract text from an image using Google Vision and write JSON output")
  .requiredOption("--input <path>", "Screenshot or image path")
  .option("--output <path>", "JSON output path")
  .action(async (options) => {
    const outputPath = await convertImageToJson({
      input: String(options.input),
      output: options.output === undefined ? undefined : String(options.output),
      config: getVisionConfig()
    });

    console.log(`Wrote ${outputPath}`);
  });

program.parseAsync(process.argv).catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`Error: ${message}`);
  process.exitCode = 1;
});
