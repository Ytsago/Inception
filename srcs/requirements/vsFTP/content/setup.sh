#!/bin/bash

echo "Creating the FTP server..."

if ! getent passwd | grep Damien ; then
	echo "Creating User..."
	useradd Damien -m
	echo Damien:"Hello" | chpasswd
	mkdir -p /var/run/vsftpd/empty
	chown root:root /var/run/vsftpd/empty
	chmod 555 /var/run/vsftpd/empty
	chmod 755 /home/Damien
fi

echo "Starting the FTP server..."
exec /usr/sbin/vsftpd /vsftpd.conf
