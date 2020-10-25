#!/bin/bash



#ls -al
#ls -al /var/www/html/wp-content/
#ls -al /var/www/html/wp-content/plugins


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

chown -R nobody:nogroup /var/www/html

apachectl -D FOREGROUND
