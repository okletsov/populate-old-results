# populate-old-results

Connects to MariaDB using environment variables and reads `information_schema` for the configured database.

## Setup

1. Install Node.js 20+.
2. `npm install`
3. Edit `.env` (placeholders are included) with your real `DB_*` values.

## Commands

- `npm run check` — TypeScript check
- `npm run schema` — Connect and print JSON: table names and `columnsByTable` from `information_schema`
- `npm run query` — Run one read-only `SELECT` (or `WITH ... SELECT`); pass SQL with `--sql`
- `npm run ocr` — Extract text from an image using Google Vision and write description-only JSON; pass the image path with `--input`

### Run a simple SELECT

From the project directory, with `.env` configured:

**cmd.exe**

```bat
npm run query -- --sql "SELECT 1 AS one"
```

**PowerShell**

```powershell
npm run query -- --sql "SELECT 1 AS one"
```

**Example using your database name from `.env`** (default database is already set on the pool via `DB_NAME`):

```powershell
npm run query -- --sql "SELECT DATABASE() AS current_db"
```

Restrictions:

- One statement only (optional single trailing `;`).
- Allowed: `SELECT ...` and `WITH ... SELECT ...` with no `INSERT` / `UPDATE` / `DELETE` / `REPLACE` in the text.
- Not allowed: `SELECT ... INTO OUTFILE`, `SELECT ... INTO DUMPFILE`.

### Convert a screenshot to OCR JSON

From the project directory, with `.env` configured for Google Vision:

```powershell
npm run ocr -- --input data_files/data_to_process/2013_spring/arabijoni.JPG
```

By default, the JSON file is written to `VISION_OUTPUT_DIR` using the image file name. Set `VISION_OUTPUT_DIR` to the relevant `data_files/data_to_process/<season>` folder:

```text
data_files/data_to_process/2013_spring/arabijoni.json
```

The JSON output is a top-level array of OCR entries. Each entry contains only a `description` field.

To choose an explicit output file:

```powershell
npm run ocr -- --input data_files/data_to_process/2013_spring/arabijoni.JPG --output data_files/data_to_process/2013_spring/arabijoni.json
```

Parameters:

- `--input <path>` — Required screenshot or image path.
- `--output <path>` — Optional JSON output path. If omitted, output is written under `VISION_OUTPUT_DIR`.

## Environment

| Variable       | Description        |
|----------------|--------------------|
| `DB_HOST`      | Server host        |
| `DB_PORT`      | Port (default 3306)|
| `DB_USER`      | Username           |
| `DB_PASSWORD`  | Password           |
| `DB_NAME`      | Database/schema    |
| `GOOGLE_CLOUD_PROJECT` | Google Cloud project with Vision enabled |
| `VISION_INPUT_DIR` | Default folder for screenshot/image files |
| `VISION_OUTPUT_DIR` | Folder where OCR JSON files are written |
