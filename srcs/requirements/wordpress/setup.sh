#!/bin/bash

sleep 10

if [ -d wordpress ]; then
mv wordpress /var/www/html/wordpress
cd /var/www/html/
chown -R www-data:www-data wordpress/
cd wordpress/
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
mv wp-config-sample.php wp-config.php

sed -i "s/\(define( 'DB_NAME', '\).*$/\1$DB_NAME' );/" wp-config.php
sed -i "s/\(define( 'DB_USER', '\).*$/\1$DB_USER' );/" wp-config.php
sed -i "s/\(define( 'DB_PASSWORD', '\).*$/\1$DB_PASS' );/" wp-config.php
sed -i "s/\(define( 'DB_HOST', '\).*$/\1$DB_HOST' );/" wp-config.php
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf
fi

exec /usr/sbin/php-fpm8.2 -F
