#!/bin/bash

echo "  ____   __    ___  __ _  _  _      __ _   __    ___  __  __   ____  "
echo " (  _ \ /  \  / __)(  / )( \/ )___ (  ( \ / _\  / __)(  )/  \ / ___) "
echo "  )   /(  O )( (__  )  (  )  /(___)/    //    \( (_ \ )((  O )\___ \ "
echo " (__\_) \__/  \___)(__\_)(__/      \_)__)\_/\_/ \___/(__)\__/ (____/ "

echo 
echo "Login using nagiosadmin / YOURPASSWORD at http://localhost:8000/nagios"
echo

echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

echo "Starting PHP-FPM in background"
php-fpm -D

echo "Starting Httpd"


/etc/init.d/nagios start



/usr/sbin/httpd -k start



