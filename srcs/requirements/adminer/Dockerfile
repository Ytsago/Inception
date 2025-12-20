FROM debian:12

RUN apt update && apt install -y \
	wget \
	php8.2-fpm \
	php8.2-mysql

RUN mkdir -p /var/www/html/adminer && \
wget "https://www.adminer.org/latest.php" -O \
	/var/www/html/adminer/index.php

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

CMD ["/usr/sbin/php-fpm8.2", "-F"]
