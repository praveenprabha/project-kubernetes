#!/bin/bash


echo -e '<VirtualHost *:80>'
echo -e '\tServerAdmin webmaster@localhost'
echo -e '\tDocumentRoot /var/www/html'
echo -e '\tErrorLog logs/wordpress_error.log'
echo -e '\tCustomLog logs/access_access.log combined'
echo -e '\n'
echo -e '\t<Directory /var/www/html/>'
echo -e '\t\tOptions -Indexes'
echo -e '\t\tAllowOverride All'
echo -e '\t</Directory>'
echo -e '</VirtualHost>'
