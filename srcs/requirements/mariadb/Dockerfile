FROM debian:12

RUN apt update -y && apt install -y mariadb-server 

# RUN apt install mariadb-client

# RUN apt install -y mysql-common

COPY ./content/setup.sh /

RUN chmod +x setup.sh

ENTRYPOINT ["sh", "setup.sh"]
