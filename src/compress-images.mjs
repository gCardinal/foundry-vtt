import tinify from "tinify";
import {
  getCompressedImageCache,
  getImagePaths,
  loadEnvFile,
  updateCompressedImageCache,
} from "./compress/index.mjs";

await loadEnvFile();

if (process.env.COMPRESS_WITH_TINY_PNG !== "true") {
  console.log(
    `COMPRESS_WITH_TINY_PNG set to [${process.env.COMPRESS_WITH_TINY_PNG}], skipping.`
  );
  process.exit(0);
}

if (!process.env.TINY_PNG_API_KEY) {
  console.log(`Missing TINY_PNG_API_KEY. Please set it in .env.local.`);
  process.exit(0);
}

tinify.key = process.env.TINY_PNG_API_KEY;

const cache = await getCompressedImageCache();
const imagePaths = await getImagePaths(process.env.IMAGE_FILE_GLOB);

console.log(`Found ${imagePaths.length} images to compress.`);

await Promise.allSettled(
  imagePaths
    .map(async (imagePath, index) => {
      console.log(
        `Compressing ${imagePath} (${index + 1} of ${imagePaths.length})`
      );

      if (cache.includes(imagePath)) {
        console.log(
          `Skipping ${imagePath} (${index + 1} of ${
            imagePaths.length
          }). Previously compressed.`
        );

        return;
      }

      const source = tinify.fromFile(imagePath);
      await source.toFile(imagePath);

      cache.push(imagePath);

      console.log(
        `Compression finished: ${imagePath} (${index + 1} of ${
          imagePaths.length
        }).`
      );
    })
    .filter(Boolean)
);

await updateCompressedImageCache(cache);
