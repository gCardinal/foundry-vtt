include ./config/make/variables.mk

default: help

## Backup local Foundry data to a zip file
backup-data:
	@zip -r backup-$(shell date +%Y%m%d%H%M%S).zip $(shell pwd)/var/foundry/data

## Open a bash session in the Foundry container
bash:
	bin/docker-compose run --rm --entrypoint bash foundry

## Force rebuild Docker images
build:
	bin/docker-compose build

## Displays running container logs
logs:
	bin/docker-compose logs --tail 200 -f

## [DESTRUCTIVE] Push local data to the server
push-data:
	@rsync -azP ./var foundry:/home/guy/apps/foundry-vtt

## Restart the development server
restart: stop start

## Starts Foundry as a background process
start:
	bin/docker-compose up -d

## Start Foundry as a foreground process
start-debug:
	bin/docker-compose up

## Display status of running containers
status:
	bin/docker-compose ps

## Stops running app and server
stop:
	bin/docker-compose stop

## Update Foundry to the latest version (will restart the server!)
update: stop
	bin/docker-compose pull
	bin/docker-compose up -d

include ./config/make/help-target.mk
