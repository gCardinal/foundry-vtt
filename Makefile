include ./config/make/variables.mk

default: help

## Backup local Foundry data to a zip file
backup-local-data:
	@zip -r backup-$(shell date +%Y%m%d%H%M%S).zip var/foundry/data -x "var/foundry/data/Data/systems/*" "var/foundry/data/Data/modules/*"

## Backup server Foundry data to a zip file
backup-server-data:
	@ssh foundry 'cd ${FOUNDRY_SERVER_PATH} && make backup-local-data'

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
	@rsync -azP ./var foundry:${FOUNDRY_SERVER_PATH}

## Pull data from the server
pull-data:
	@rsync -azP foundry:${FOUNDRY_SERVER_PATH}/var .

## Restart the development server
restart: stop start

## Restore selected local backup. Run with `BACKUP=backupName.zip make restore-local-data`.
restore-local-data:
	unzip -o ${BACKUP}

## Restore selected server backup. Run with `BACKUP=backupName.zip make restore-server-data`.
restore-server-data:
	ssh foundry 'cd ${FOUNDRY_SERVER_PATH} && unzip -o ${BACKUP}'

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
