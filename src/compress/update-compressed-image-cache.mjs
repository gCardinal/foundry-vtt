import { writeFile } from "fs/promises";

export const updateCompressedImageCache = async (contents) => {
  return await writeFile(
    process.env.COMPRESSED_IMAGE_CACHE_FILE,
    JSON.stringify(contents)
  );
};
