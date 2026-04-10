FROM debian:12

RUN apt update && apt install -y \
	wget \
	php8.2-fpm \
	php8.2-mysql \
	netcat-traditional \
	inetutils-ping

COPY ./content/setup.sh /

ENTRYPOINT ["sh", "setup.sh"]
