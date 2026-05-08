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

const visionEnvSchema = z.object({
  GOOGLE_CLOUD_PROJECT: z.string().min(1),
  VISION_INPUT_DIR: z.string().min(1),
  VISION_OUTPUT_DIR: z.string().min(1)
});

export type DbConfig = z.infer<typeof envSchema>;
export type VisionConfig = z.infer<typeof visionEnvSchema>;

export function getDbConfig(): DbConfig {
  return envSchema.parse(process.env);
}

export function getVisionConfig(): VisionConfig {
  return visionEnvSchema.parse(process.env);
}
