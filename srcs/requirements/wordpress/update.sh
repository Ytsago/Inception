curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp --info

wp core install \
	--allow-root\
	--url="https://secros.42lyon"\
	--title="MyAnwsomWebsite"\
	--admin_user="admin"\
	--admin_password="admin"\
	--admin_email="yes@yes.com"\
	--skip-email\
	--path="/var/www/html/wordpress"
