import glob from "glob";

export const getImagePaths = async (path) =>
  new Promise((resolve, reject) => {
    glob(path, (err, paths) => {
      if (err) {
        reject(err);
      }

      resolve(
        paths
          .filter((item) => !item.includes("/modules/"))
          .filter((item) => !item.includes("/systems/"))
      );
    });
  });
