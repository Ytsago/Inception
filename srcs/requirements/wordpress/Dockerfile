FROM debian:12

RUN apt update && apt install -y wget
RUN apt install php8.2-fpm -y

RUN apt install php8.2-mysql -y

RUN wget https://wordpress.org/latest.tar.gz && \
tar -xzf latest.tar.gz && rm latest.tar.gz

COPY setup.sh /

ENTRYPOINT ["sh", "setup.sh"]
