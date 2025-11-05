#!/bin/bash/

mariadb << eof
CREATE DATABASE WORDPRESS;
USE WORDPRESS;
CREATE TABLE USER (userid int AUTO_INCREMENT PRIMARY KEY, username varchar(255), role varchar(255));
INSERT INTO USER (username, role) VALUES('User1', 'admin');
eof
