FROM debian:12

RUN apt update -y && apt install -y nginx

RUN apt install -y openssl && mkdir -p /etc/ssl/private /etc/ssl/certs && \
openssl req -newkey rsa:2048 -x509 -nodes -keyout /etc/ssl/private/nginx_selfkey.key \
-out /etc/ssl/certs/nginx_selfcert.crt -subj "/C=FR/ST=RHONE/L=Lyon/O=42/OU=Student/CN=secros.42lyon.fr"

RUN apt remove -y openssl

# COPY content/index.html /var/www/html/index.nginx-debian.html

COPY ./content/based.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

