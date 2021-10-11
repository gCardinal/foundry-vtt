include ./config/make/variables.mk

default: help

## Open a bash session in the Foundry container
bash:
	bin/docker-compose run --rm --entrypoint bash foundry

## Force rebuild Docker images
build:
	bin/docker-compose build

## Displays running container logs
logs:
	bin/docker-compose logs --tail 200 -f

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
