#!/bin/bash



#ls -al
#ls -al /var/www/html/wp-content/
#ls -al /var/www/html/wp-content/plugins

a2enmod rewrite

echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Updating the /etc/apache2/sites-available/000-default.conf with correct option to allow .htaccess and disable directory index
{ 
	echo -e '<VirtualHost *:80>'
	echo -e '\tServerAdmin webmaster@localhost'
	echo -e '\tDocumentRoot /var/www/html'
	echo -e '\tErrorLog ${APACHE_LOG_DIR}/error.log'
	echo -e '\tCustomLog ${APACHE_LOG_DIR}/access.log combined'
	echo -e '\n'
	echo -e '\t<Directory /var/www/html/>'
	echo -e '\t\tOptions -Indexes'
	echo -e '\t\tAllowOverride All'
	echo -e '\t</Directory>'
	echo -e '</VirtualHost>'
} | tee /etc/apache2/sites-available/000-default.conf





{
	echo -e '# BEGIN WordPress'
	echo -e '<IfModule mod_rewrite.c>'
	echo -e 'RewriteEngine On'
	echo -e 'RewriteBase /'
	echo -e 'RewriteRule ^index\.php$ - [L]'
	echo -e 'RewriteCond %{REQUEST_FILENAME} !-f'
	echo -e 'RewriteCond %{REQUEST_FILENAME} !-d'
	echo -e 'RewriteRule . /index.php [L]'
	echo -e '</IfModule>'
	echo -e '# END WordPress'
} | tee  /var/www/html/.htaccess




cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/g" /var/www/html/wp-config.php


sed -i '/'"'WP_DEBUG'"'/a \
// Cache all the things \
global $memcached_servers; \
$memcached_servers = array( \
 array( \
    "'"$MEMCAHED_HOST"'", \
    "11211" \
    ) \
 ); \
define( "WP_CACHE", true );' /var/www/html/wp-config.php

#exec /usr/local/bin/docker-entrypoint.sh apache2-foreground

sed -i 's/\(var \$headers = array(\)\()\)/\1"memcached" => "activated-by-praveen"\2/g' /var/www/html/wp-content/advanced-cache.php

chown -R www-data:www-data /var/www/html
find /var/www/html -type f -exec chmod 644 {} \;
find /var/www/html -type d -exec chmod 755 {} \;


apachectl -D FOREGROUND
