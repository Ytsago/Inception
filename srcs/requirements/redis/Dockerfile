FROM debian:12

RUN apt update && apt install -y \
	redis-server

CMD ["redis-server", "--protected-mode", "no"]
