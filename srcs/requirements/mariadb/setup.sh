#!/bin/bash/

mysqld_safe --datadir=/var/lib/mysql &

until mariadb -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done

if ! mariadb -e 'SHOW DATABASES;' | grep -q $DB_NAME ; then
mariadb << eof
DROP DATABASE IF EXISTS test;
CREATE DATABASE $DB_NAME;
USE $DB_NAME;
CREATE TABLE USER (userid int AUTO_INCREMENT PRIMARY KEY, username varchar(255), role varchar(255));
INSERT INTO USER (username, role) VALUES('User1', 'admin');
INSERT INTO USER (username, role) VALUES('User2', 'user');
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
eof
fi

service mariadb stop

exec /usr/bin/mariadbd-safe
