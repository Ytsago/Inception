FROM debian:12

RUN apt update && apt install -y wget

RUN wget https://wordpress.org/latest.tar.gz && \
tar -xzf latest.tar.gz && rm latest.tar.gz

CMD ["tail", "-f" ,"/dev/urandom"]

