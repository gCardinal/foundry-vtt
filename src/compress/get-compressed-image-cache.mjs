import { existsSync } from "fs";
import { readFile } from "fs/promises";

export const getCompressedImageCache = async () => {
  if (!existsSync(process.env.COMPRESSED_IMAGE_CACHE_FILE)) {
    return [];
  }

  const contents = await readFile(
    process.env.COMPRESSED_IMAGE_CACHE_FILE,
    "utf8"
  );

  return JSON.parse(contents);
};
