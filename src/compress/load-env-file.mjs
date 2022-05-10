import { readFile } from "fs/promises";
import { parse } from "dotenv";

export const loadEnvFile = async () => {
  const contents = await Promise.allSettled([
    readFile(".env", "utf8"),
    readFile(".env.local", "utf8"),
  ]);

  Object.assign(
    process.env,
    contents
      .filter((x) => x.status === "fulfilled")
      .reduce((acc, x) => ({ ...acc, ...parse(x.value) }), {})
  );
};
