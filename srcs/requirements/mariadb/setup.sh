#!/bin/bash/

# tail -f /dev/urandom

# if [ ! -d "/run/mysqld" ]; then
    # mkdir -p /run/mysqld
    # chown mysql:mysql /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
	# mysql_install_db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
# fi

mysqld_safe --datadir=/var/lib/mysql &

until mariadb -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done

mariadb << eof
CREATE DATABASE WORDPRESS;
USE WORDPRESS;
CREATE TABLE USER (userid int AUTO_INCREMENT PRIMARY KEY, username varchar(255), role varchar(255));
INSERT INTO USER (username, role) VALUES('User1', 'admin');
INSERT INTO USER (username, role) VALUES('User2', 'user');
eof

service mariadb stop

exec /usr/bin/mariadbd-safe
