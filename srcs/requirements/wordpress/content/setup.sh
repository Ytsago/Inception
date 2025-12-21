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

	echo "Creating the config file"
	wp core install \
		--allow-root \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PASS" \
		--admin_email="$WP_ADMIN_MAIL" \
		--skip-email \
		--path="/var/www/html/wordpress"
	echo "Done !"

	echo "Installing the redis plugin"
	wp plugin install \
		redis-cache \
		--allow-root \
		--activate

	sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i \
define('WP_REDIS_HOST', 'redis');\n\
define('WP_REDIS_PORT', '6379');\n\
define('WP_CACHE', true);
" wp-config.php

	echo "Testing connection"
	until wp redis enable --allow-root; do
		echo "failed"
		sleep 1;
	done

	wp theme install impressionist --allow-root --activate
	
	wp user create \
		$WP_USER \
		$WP_USER_MAIL \
		--allow-root \
		--role="$WP_USER_ROLE" \
		--user_pass="$WP_USER_PASS"
else
	echo "Wordpress is already installed"
fi
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm8.2 -F
