build:
	sudo docker compose -f ./srcs/docker-compose.yml up --build --force-recreate -d

up:
	sudo docker compose -f ./srcs/docker-compose.yml up -d

stop:
	sudo docker compose -f ./srcs/docker-compose.yml stop

down:
	sudo docker compose -f ./srcs/docker-compose.yml down

status:
	@sudo docker image ls
	@sudo docker ps -a

clear_vol:
	rm -rf /var/www/html/db/*
	rm -rf /var/www/html/web/*

clear: down clear_vol
	sudo docker system prune --all -f
