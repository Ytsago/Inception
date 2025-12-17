#!/bin/bash

if ! [ -d /var/www/html/wordpress ]; then
	echo "Wordpress not found begin installation !"
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp && \
		wp --info

	mkdir -p /var/www/html/wordpress && \
		cd /var/www/html/wordpress
	
	wp core download --allow-root

	wp config create --allow-root \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASS" \
		--dbhost="$DB_HOST"

	echo "Waiting for MariaDB connection..."
	apt install mariadb-client -y
	until wp db check --allow-root; do
		sleep 1;
	done
	apt remove mariadb-client -y
	echo "MariaDB is connected !"

	wp core install \
		--allow-root \
		--url="https://secros.42lyon.fr:4242" \
		--title="MyAnwsomWebsite" \
		--admin_user="admin" \
		--admin_password="admin" \
		--admin_email="yes@yes.com" \
		--skip-email \
		--path="/var/www/html/wordpress"
	
	wp user create secros secros@secrosmail.com \
		--allow-root \
		--role="editor" \
		--user_pass="Banane"
else
	echo "Wordpress is already installed"
fi
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm8.2 -F
