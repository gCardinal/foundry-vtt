# Colors
color_reset   = \033[0m
color_info    = \033[32m
color_comment = \033[33m

# Environment Variables
ENV?=local
include .env
-include .env.local
-include .${ENV}
-include .${ENV}.local
