import {
  createPool as createMariaPool,
  type Pool,
  type PoolConnection
} from "mariadb";
import type { DbConfig } from "../config/env.js";

let pool: Pool | null = null;

export function createPool(config: DbConfig): Pool {
  if (!pool) {
    pool = createMariaPool({
      host: config.DB_HOST,
      port: config.DB_PORT,
      user: config.DB_USER,
      password: config.DB_PASSWORD,
      database: config.DB_NAME,
      connectionLimit: 5
    });
  }

  return pool;
}

export async function withConnection<T>(
  dbPool: Pool,
  action: (connection: PoolConnection) => Promise<T>
): Promise<T> {
  const connection = await dbPool.getConnection();
  try {
    return await action(connection);
  } finally {
    connection.release();
  }
}

export async function closePool(): Promise<void> {
  if (pool) {
    await pool.end();
    pool = null;
  }
}
