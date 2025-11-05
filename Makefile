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

clear: down
	sudo docker system prune --all -f
	sudo docker volume rm $(sudo docker volume ls -q)

