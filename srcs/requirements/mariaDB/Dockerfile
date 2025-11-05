FROM debian:12

RUN apt update -y && apt install -y mariadb 

COPY content/index.html /var/www/html/index.nginx-debian.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

