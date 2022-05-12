Foundry VTT
===

Docker-based Foundry VTT installation.

## Install
1. Clone this repository on the server.
2. Create a `.env.local` file to configure sensitive information (empty variables in `.env`).
3. Run `make start`.

Foundry will be available at `http://localhost:${EXPOSED_FOUNDRY_PORT}`. The container will also be restarted on server
restart unless you specifically stop it via `make stop`.

## Configurations

Everything that can be configured for Foundry is configurable in this project. We use `.env` files to do so, with a 
specific loading order (next one overrides the previous one): 

- .env
- .env.local
- .env.${ENV} (`ENV` being defined by the environment, for example `ENV=staging make start`)
- .env.${ENV}.local

Whenever you want to override something, you can do so most of the time in `.env.local`. `.local` files are ignored, so
while information is still on the server itself, at least you're not committing sensitive information to the
*cloud-hosted* repository!

## Updating
Run `make update`. **Be aware**, Foundry ***will*** be stopped to execute the update.

## Data
Foundry's data is kept in a local file volume that is, by default `./var/foundry/data`.

## Tooling
We provide a `Makefile` will all the commands and utilities you might need to work with this project. Run `make` to get
a list of available commands and a small description of that they do. You can also dig into the `Makefile` for even more
insight.

## Utilities

### Image compression
To save on disk space and provide faster load times, images can be easily compressed by running
`make compress-local-images`.

The command will run two scripts. The first is [fvttoptimizer][1] (via a Docker container), which will convert all
non-webp images in foundry's `Data` directory to webp. More details can be found in the project's [README.md][1].

Once all images are converted to webp, we further compress by running them through [TinyPNG][2]. It's a bit overkill and
you do need an API key, but it'll save on average a further 5% space.

You can skip the TinyPNG step by setting `COMPRESS_WITH_TINY_PNG=false` in a `.env.local` file. This is also where you
would want to set your own API key.

[1]: https://github.com/watermelonwolverine/fvttoptimizer
[2]: https://tinypng.com/
