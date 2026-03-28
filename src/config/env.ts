import dotenv from "dotenv";
import { z } from "zod";

dotenv.config();

const envSchema = z.object({
  DB_HOST: z.string().min(1),
  DB_PORT: z.coerce.number().int().positive().default(3306),
  DB_USER: z.string().min(1),
  DB_PASSWORD: z.string(),
  DB_NAME: z.string().min(1)
});

export type DbConfig = z.infer<typeof envSchema>;

export function getDbConfig(): DbConfig {
  return envSchema.parse(process.env);
}
