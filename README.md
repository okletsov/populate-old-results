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

## Environment

| Variable       | Description        |
|----------------|--------------------|
| `DB_HOST`      | Server host        |
| `DB_PORT`      | Port (default 3306)|
| `DB_USER`      | Username           |
| `DB_PASSWORD`  | Password           |
| `DB_NAME`      | Database/schema    |
