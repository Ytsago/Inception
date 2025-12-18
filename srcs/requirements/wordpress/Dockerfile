FROM debian:12

RUN apt update && apt install -y wget
RUN apt install php8.2-fpm -y

RUN apt install php8.2-mysql -y

COPY ./content/setup.sh /

ENTRYPOINT ["sh", "setup.sh"]
