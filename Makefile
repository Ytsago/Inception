# -------COLOR--------
GREEN  = \033[32m
YELLOW = \033[33m
BLUE   = \033[34m
RED    = \033[31m
RESET  = \033[0m

# -------VAR---------
USER			= secros
DATA_PATH		= /home/$(USER)/data
COMPOSE_FILE	= ./srcs/docker-compose.yml
DOCKER_COMPOSE	= sudo docker compose -f $(COMPOSE_FILE)
DOCK			=
SH				= 

# -------RULES-------

all: build up

build: set_dir
	@echo "$(GREEN)Building docker images...$(RESET)";
	@$(DOCKER_COMPOSE) build

up: set_dir
	@echo "$(GREEN)Starting containers$(RESET)";
	@$(DOCKER_COMPOSE) up -d

set_dir:
	@echo "$(BLUE)Creating data directories... $(RESET)";
	@mkdir -p $(DATA_PATH)/web $(DATA_PATH)/db

stop:
	@echo "$(YELLOW)Stopping containers...$(RESET)";
	$(DOCKER_COMPOSE) stop

down:
	@echo "$(RED)Removing containers...$(RESET)";
	$(DOCKER_COMPOSE) down

status:
	@echo "\n$(GREEN)--- IMAGES ---$(RESET)";
	@sudo docker image ls
	@echo "\n$(GREEN)--- VOLUMES ---$(RESET)";
	@sudo docker volume ls
	@echo "\n$(GREEN)--- CONTAINERS ---$(RESET)";
	@sudo docker ps -a

shell:
ifeq ($(DOCK),)
	@echo "Usage: make shell DOCK=<container> [SH=shell]"
	@exit 1
endif
	sudo docker exec -it $(DOCK) $(if $(SH),$(SH),bash)

logs:
ifeq ($(DOCK),)
	@echo "Usage: make logs DOCK=<container>"
	@exit 1
endif
	sudo docker logs $(DOCK)

clean:
	@echo "$(RED)Removing containers and images...$(RESET)";
	@$(DOCKER_COMPOSE) down --rmi all;

vclean:
	@echo "$(RED)Removing volumes and data...$(RESET)";
	@if [ $$(sudo docker ps -aq | wc -l) -gt 0 ]; then \
		make down --no-print-directory; fi
	@if [ -n "$$(sudo docker volume ls -q)" ]; then \
		sudo docker volume rm $$(sudo docker volume ls -q); \
	fi
	@sudo rm -rf $(DATA_PATH)/web $(DATA_PATH)/db;

cclean:
	@echo "$(RED)Removing cache... $(RESET)";
	@sudo docker builder prune -af

fclean: clean vclean cclean

re: fclean up

.PHONY: all shell build up down stop set_dir clean vclean cclean fclean re
