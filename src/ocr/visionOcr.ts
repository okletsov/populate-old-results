import { ImageAnnotatorClient } from "@google-cloud/vision";
import { mkdir, stat, writeFile } from "node:fs/promises";
import path from "node:path";
import type { VisionConfig } from "../config/env.js";

export type ConvertImageToJsonOptions = {
  input: string;
  output?: string;
  config: VisionConfig;
};

export type OcrJsonOutput = {
  description: string;
}[];

export async function convertImageToJson(
  options: ConvertImageToJsonOptions
): Promise<string> {
  const inputPath = path.resolve(options.input);
  const outputPath = path.resolve(
    options.output ?? getDefaultOutputPath(options.input, options.config)
  );

  await assertFileExists(inputPath);
  await mkdir(path.dirname(outputPath), { recursive: true });

  const client = new ImageAnnotatorClient({
    projectId: options.config.GOOGLE_CLOUD_PROJECT
  });

  const [result] = await client.textDetection(inputPath);
  const output: OcrJsonOutput = (result.textAnnotations ?? [])
    .map((annotation) => annotation.description)
    .filter((description): description is string => {
      return typeof description === "string" && description.trim().length > 0;
    })
    .map((description) => ({ description }));

  await writeFile(outputPath, `${JSON.stringify(output, null, 2)}\n`, "utf8");

  return outputPath;
}

function getDefaultOutputPath(input: string, config: VisionConfig): string {
  const parsedInput = path.parse(input);
  return path.join(config.VISION_OUTPUT_DIR, `${parsedInput.name}.json`);
}

async function assertFileExists(filePath: string): Promise<void> {
  try {
    const fileStat = await stat(filePath);

    if (!fileStat.isFile()) {
      throw new Error(`Input path is not a file: ${filePath}`);
    }
  } catch (error) {
    if (isNodeError(error) && error.code === "ENOENT") {
      throw new Error(`Input image does not exist: ${filePath}`);
    }

    throw error;
  }
}

function isNodeError(error: unknown): error is NodeJS.ErrnoException {
  return error instanceof Error && "code" in error;
}
