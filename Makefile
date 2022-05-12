include ./config/make/variables.mk

default: help

##@ Data

backup-local-data: ## Backup local Foundry data to a zip file
	@zip -r backup-$(shell date +%Y%m%d%H%M%S).zip var/foundry/data -x "var/foundry/data/Data/systems/*" "var/foundry/data/Data/modules/*"

backup-server-data: ## Backup server Foundry data to a zip file
	@ssh foundry 'cd ${FOUNDRY_SERVER_PATH} && make backup-local-data'

compress-local-images: ## Compress local images using fvttoptimizer. Foundry WILL be stopped. PLEASE MAKE A BACKUP BEFOREHAND.
	bin/docker-compose run --rm fvttoptimizer
	bin/docker-compose run --rm node src/compress-images.mjs

push-data: ## [DESTRUCTIVE] Push local data to the server
	@rsync -azP ./var foundry:${FOUNDRY_SERVER_PATH}

pull-data: ## Pull data from the server
	@rsync -azP foundry:${FOUNDRY_SERVER_PATH}/var .

restore-local-data: ## Restore selected local backup. Run with `BACKUP=backupName.zip make restore-local-data`.
	unzip -o ${BACKUP}

restore-server-data: ## Restore selected server backup. Run with `BACKUP=backupName.zip make restore-server-data`.
	ssh foundry 'cd ${FOUNDRY_SERVER_PATH} && unzip -o ${BACKUP}'

##@ Docker

bash: ## Open a bash session in the Foundry container
	bin/docker-compose run --rm --entrypoint bash foundry

build: ## Force rebuild Docker images
	bin/docker-compose build

logs: ## Displays running container logs
	bin/docker-compose logs --tail 200 -f

restart: stop start ## Restart the development server

start: ## Starts Foundry as a background process
	bin/docker-compose up -d foundry

start-debug: ## Start Foundry as a foreground process
	bin/docker-compose up foundry

status: ## Display status of running containers
	bin/docker-compose ps

stop: ## Stops running app and server
	bin/docker-compose stop

##@ Foundry

update: stop ## Update Foundry to the version specified in config/docker-compose.yml
	bin/docker-compose pull
	bin/docker-compose up -d

include ./config/make/help-target.mk
