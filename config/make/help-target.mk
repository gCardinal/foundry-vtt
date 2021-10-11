# This guy is pretty heavy and ugly, so we're hiding him D:

# It's configurable, but lost in the mess under, so, here you go, shortcut!
NUMBER_OF_CHARACTERS_FOR_COMMAND_COLUMN=20

## Prints this help.
help:
	@printf "${color_comment}Usage:${color_reset}\n"
	@printf " make [target]\n\n"
	@printf "${color_comment}Available commands:${color_reset}\n"
	@awk '/^[a-zA-Z\-0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${color_info}%-${NUMBER_OF_CHARACTERS_FOR_COMMAND_COLUMN}s${color_reset} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort
	@echo " "
