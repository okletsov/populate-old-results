import type { Pool } from "mariadb";
import { assertReadOnlySelect } from "./assertReadOnlySelect.js";

export async function executeReadOnlySelect(
  pool: Pool,
  sql: string
): Promise<unknown> {
  assertReadOnlySelect(sql);
  return pool.query(sql);
}
