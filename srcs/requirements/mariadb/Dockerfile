FROM debian:12

RUN apt update -y && apt install -y mariadb-server 

COPY setup.sh /

RUN chmod +x setup.sh

ENTRYPOINT ["sh", "setup.sh"]
