# Automate commands

up:
	docker compose up -d --build

down:
	docker compose down

prune:
	docker volume prune -a
	docker network prune
	docker system prune -a
	docker builder prune -a

status:
	@docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}\t{{.State}}\t{{.Size}}\t{{.Mounts}}\t{{.Networks}}'

doune:
	docker compose down
	docker volume prune -a
	docker network prune
	docker system prune -a
	docker builder prune -a

# Variables
CONTAINER_DOWN_MSG = [OK] Containers downed successfully
PRUNING_MSG = [OK] Docker pruned successfully
MSG_DB_DUMP = [OK] Database dumped successfully
MSG_DB_RESTORE = [OK] Database restore successfully
SUCCESS_MSG = [OK] DEV environment started successfully

rebuild:
	@echo "${BLUE}Downing containters...${RESET}"
	@echo ""
	docker compose down
	@echo ""
	$(call display_message, $(CONTAINER_DOWN_MSG))
	@echo ""
	@echo "${BLUE}Pruning docker...${RESET}"
	@echo ""
	docker volume prune -a -f
	docker network prune -f
	docker system prune -a -f
	docker builder prune -a -f
	# Stop all containers
	# docker stop `docker ps -qa`
	# Remove all containers
	# docker rm `docker ps -qa`
	# Remove all images
	# docker rmi -f `docker images -qa`
	# Remove all volumes
	# docker volume rm $(docker volume ls -q)
	# Remove all networks
	# docker network rm `docker network ls -q`
	@echo ""
	$(call display_message, $(PRUNING_MSG))
	@echo ""
	@echo "${BLUE}Starting development environment...${RESET}"
	@echo ""
	docker compose up -d --build
	@echo ""
	$(call display_message, $(SUCCESS_MSG))
	@echo ""

aaaa:
	chmod +x clean-docker.sh
	./clean-docker.sh

# ==============================================================================
# UTILITY TARGETS
# ==============================================================================

# ANSI color codes
GREEN_BG = \033[42m
BLACK = \033[30m
BLUE = \033[0;34m
RESET = \033[0m

# Create a line of 50 characters
LINE_WIDTH = 120
START_POS = 1

# Define a function to print a green line
define green_line
	printf "$(GREEN_BG)$(BLACK)%*s$(RESET)\n" $(LINE_WIDTH) ""
endef

# Function to display a message
define display_message
	@$(eval MSG_TEXT := $1)
	@$(eval TEXT_LENGTH := $(shell printf "%s" "$(MSG_TEXT)" | wc -m))
	@$(eval LEFT_PAD := $(START_POS))
	@$(eval RIGHT_PAD := $(shell expr $(LINE_WIDTH) - $(LEFT_PAD) - $(TEXT_LENGTH)))

	@$(green_line)
	@printf "$(GREEN_BG)$(BLACK)%*s%s%*s$(RESET)\n" $(LEFT_PAD) "" "$(MSG_TEXT)" $(RIGHT_PAD) ""
	@$(green_line)
endef