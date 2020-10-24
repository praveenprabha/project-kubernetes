FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get  install -y apache2 libapache2-mod-php php-mysql  php-memcached

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN rm /var/www/html/index.html

COPY wordpress /var/www/html

#From https://github.com/bonny/memcachy
COPY object-cache-memcache.php /var/www/html/wp-content/.
COPY object-cache-memcached.php /var/www/html/wp-content/.
COPY object-cache.php /var/www/html/wp-content/.


# From https://downloads.wordpress.org/plugin/batcache.1.5.zip
COPY batcache/advanced-cache.php /var/www/html/wp-content/.
COPY batcache/batcache.php /var/www/html/wp-content/plugins/.

COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

CMD ["./entrypoint.sh"]
