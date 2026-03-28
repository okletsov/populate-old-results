import type { Pool } from "mariadb";
import { withConnection } from "./mariadbClient.js";

export type Nullable<T> = T | null;

export interface TableColumnInfo {
  tableName: string;
  columnName: string;
  dataType: string;
  isNullable: boolean;
  columnDefault: Nullable<string>;
  columnKey: string;
  extra: string;
}

export interface InformationSchemaSnapshot {
  database: string;
  tables: string[];
  columnsByTable: Record<string, TableColumnInfo[]>;
}

function normalizeRows(
  rows: Array<TableColumnInfo & { isNullable: unknown }>
): TableColumnInfo[] {
  return rows.map((row) => ({
    ...row,
    isNullable: String(row.isNullable).toUpperCase() === "YES"
  }));
}

/** Base tables and views in the given schema (information_schema.TABLES). */
export async function listTablesInSchema(
  pool: Pool,
  dbName: string
): Promise<
  Array<{ name: string; type: "BASE TABLE" | "VIEW" | string }>
> {
  return withConnection(pool, async (connection) => {
    const rows = await connection.query(
      `
      SELECT TABLE_NAME AS name, TABLE_TYPE AS type
      FROM information_schema.TABLES
      WHERE TABLE_SCHEMA = ?
      ORDER BY TABLE_NAME;
      `,
      [dbName]
    );
    return rows as Array<{ name: string; type: string }>;
  });
}

/** All columns for the given schema (information_schema.COLUMNS). */
export async function getAllColumnsForDatabase(
  pool: Pool,
  dbName: string
): Promise<TableColumnInfo[]> {
  return withConnection(pool, async (connection) => {
    const rows = await connection.query(
      `
      SELECT
        TABLE_NAME AS tableName,
        COLUMN_NAME AS columnName,
        DATA_TYPE AS dataType,
        IS_NULLABLE AS isNullable,
        COLUMN_DEFAULT AS columnDefault,
        COLUMN_KEY AS columnKey,
        EXTRA AS extra
      FROM information_schema.COLUMNS
      WHERE TABLE_SCHEMA = ?
      ORDER BY TABLE_NAME, ORDINAL_POSITION;
      `,
      [dbName]
    );
    return normalizeRows(rows as Array<TableColumnInfo & { isNullable: unknown }>);
  });
}

export async function getInformationSchemaSnapshot(
  pool: Pool,
  dbName: string
): Promise<InformationSchemaSnapshot> {
  const tablesMeta = await listTablesInSchema(pool, dbName);
  const columns = await getAllColumnsForDatabase(pool, dbName);

  const columnsByTable: Record<string, TableColumnInfo[]> = {};
  for (const col of columns) {
    const key = col.tableName;
    columnsByTable[key] = columnsByTable[key] ?? [];
    columnsByTable[key].push(col);
  }

  return {
    database: dbName,
    tables: tablesMeta.map((t) => t.name),
    columnsByTable
  };
}
