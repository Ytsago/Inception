#!/bin/bash

mysqld_safe --datadir=/var/lib/mysql &

until mariadb -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done

if ! mariadb -e 'SHOW DATABASES;' | grep -qw $DB_NAME ; then
	echo "Creating the MariaDB database..."
mariadb << eof
DROP DATABASE IF EXISTS test;
CREATE DATABASE $DB_NAME;
USE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
eof
else
	echo "Database already exist"
fi
sed -i "s/\(bind-address\s*= \).*/\1 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb stop

exec mariadbd --datadir=/var/lib/mysql --user=mysql
