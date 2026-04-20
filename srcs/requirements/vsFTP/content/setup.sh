#!/bin/bash

echo "Creating the FTP server..."

if ! getent passwd | grep $FTP_USER > /dev/null 2>&1; then
	echo "Creating User: $FTP_USER"

	useradd -m "$FTP_USER"
	echo "$FTP_USER:$FTP_PASS" | chpasswd

	mkdir -p /var/run/vsftpd/empty
	chown root:root /var/run/vsftpd/empty
	chmod 555 /var/run/vsftpd/empty

	chown root:root "/home/$FTP_USER"
	chmod 555 "/home/$FTP_USER"

	mkdir -p "/home/$FTP_USER/upload"
	chown "$FTP_USER:$FTP_USER" "/home/$FTP_USER/upload"
	chmod 755 "/home/$FTP_USER/upload"
fi

echo "Starting the FTP server..."
exec /usr/sbin/vsftpd /vsftpd.conf
