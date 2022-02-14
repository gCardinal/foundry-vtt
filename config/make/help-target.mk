##@ Help

# It's configurable, but lost in the mess under, so, here you go, shortcut!
NUMBER_OF_CHARACTERS_FOR_COMMAND_COLUMN=22

help:  ## Display this help
	@printf 'Dockerized Foundry VTT\n'
	@printf '\n'
	@printf 'Manage and sync your Foundry instance on the server and locally.\n'
	@printf 'The local instance is usually used for testing potentially breaking\n'
	@printf 'stuff. PLEASE be careful with data syncs.\n'
	@printf '\n'
	@printf 'A lot more details on this project can be found in README.md.\n'
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-${NUMBER_OF_CHARACTERS_FOR_COMMAND_COLUMN}s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
