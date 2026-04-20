# -------COLOR--------
GREEN  = \033[32m
YELLOW = \033[33m
BLUE   = \033[34m
RED    = \033[31m
RESET  = \033[0m

# -------VAR---------
USER					= secros
DATA_PATH				= /home/$(USER)/data
COMPOSE_FILE			= ./srcs/docker-compose.yml
COMPOSE_FILE_BONUS		= ./srcs/docker-compose_bonus.yml
DOCKER_COMPOSE			= docker compose -f $(COMPOSE_FILE)
DOCKER_COMPOSE_BONUS	= docker compose -f $(COMPOSE_FILE_BONUS) 
DOCK					=
SH						= 

# -------RULES-------

all: build up

bonus: build_bonus up_bonus

build: set_dir
	@echo "$(GREEN)Building docker images...$(RESET)";
	@$(DOCKER_COMPOSE)  build

build_bonus: set_dir
	@echo "$(GREEN)Building docker images...$(RESET)";
	@$(DOCKER_COMPOSE_BONUS) build

up: set_dir
	@echo "$(GREEN)Starting containers$(RESET)";
	@$(DOCKER_COMPOSE) up -d --remove-orphans

up_bonus: set_dir
	@echo "$(GREEN)Starting containers$(RESET)";
	@$(DOCKER_COMPOSE_BONUS) up -d

set_dir:
	@echo "$(BLUE)Creating data directories... $(RESET)";
	@mkdir -p $(DATA_PATH)/web $(DATA_PATH)/db

stop:
	@echo "$(YELLOW)Stopping containers...$(RESET)";
	$(DOCKER_COMPOSE) stop

stop_bonus:
	@echo "$(YELLOW)Stopping containers...$(RESET)";
	$(DOCKER_COMPOSE_BONUS) stop

down:
	@echo "$(RED)Removing containers...$(RESET)";
	$(DOCKER_COMPOSE) down

down_bonus:
	@echo "$(RED)Removing containers...$(RESET)";
	$(DOCKER_COMPOSE_BONUS) down

status:
	@echo "\n$(GREEN)--- IMAGES ---$(RESET)";
	@docker image ls
	@echo "\n$(GREEN)--- VOLUMES ---$(RESET)";
	@docker volume ls
	@echo "\n$(GREEN)--- CONTAINERS ---$(RESET)";
	@docker ps -a

shell:
ifeq ($(DOCK),)
	@echo "Usage: make shell DOCK=<container> [SH=shell]"
	@exit 1
endif
	docker exec -it $(DOCK) $(if $(SH),$(SH),bash)

logs:
ifeq ($(DOCK),)
	@echo "Usage: make logs DOCK=<container>"
	@exit 1
endif
	docker logs $(DOCK)

clean:
	@echo "$(RED)Removing containers and images...$(RESET)";
	@$(DOCKER_COMPOSE) down --rmi all;

clean_bonus:
	@echo "$(RED)Removing containers and images...$(RESET)";
	@$(DOCKER_COMPOSE_BONUS) down --rmi all;

vclean:
	@echo "$(RED)Removing volumes and data...$(RESET)";
	@if [ $$(sudo docker ps -aq | wc -l) -gt 0 ]; then \
		make down_bonus --no-print-directory; fi
	@if [ -n "$$(sudo docker volume ls -q)" ]; then \
		sudo docker volume rm $$(sudo docker volume ls -q); \
	fi
	@rm -rf $(DATA_PATH)/web $(DATA_PATH)/db;

cclean:
	@echo "$(RED)Removing cache... $(RESET)";
	@docker builder prune -af

fclean: clean vclean cclean

fclean_bonus: clean_bonus vclean cclean

re: fclean all

re_bonus: fclean_bonus bonus

.PHONY: all shell logs build up down stop set_dir clean vclean cclean fclean re down_bonus re_bonus up_bonus stop_bonus build_bonus fclean_bonus
