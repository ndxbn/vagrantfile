#!/bin/bash -eu

systemctl restart php5.6-fpm

phpize7.0
./configure --with-php-config=/usr/bin/php-config7.0 > /dev/null
make clean > /dev/null
make >/dev/null 2>&1
make install
chmod 644 /usr/lib/php/20151012/mongodb.so
bash -c "echo 'extension=mongodb.so' > /etc/php/7.0/mods-available/mongo.ini"
ln -s /etc/php/7.0/mods-available/mongo.ini /etc/php/7.0/cli/conf.d/20-mongo.ini
ln -s /etc/php/7.0/mods-available/mongo.ini /etc/php/7.0/fpm/conf.d/20-mongo.ini
systemctl restart php7.0-fpm

phpize7.1
./configure --with-php-config=/usr/bin/php-config7.1 > /dev/null
make clean > /dev/null
make >/dev/null 2>&1
make install
chmod 644 /usr/lib/php/20160303/mongodb.so
bash -c "echo 'extension=mongodb.so' > /etc/php/7.1/mods-available/mongo.ini"
ln -s /etc/php/7.1/mods-available/mongo.ini /etc/php/7.1/cli/conf.d/20-mongo.ini
ln -s /etc/php/7.1/mods-available/mongo.ini /etc/php/7.1/fpm/conf.d/20-mongo.ini
systemctl restart php7.1-fpm

phpize7.2
./configure --with-php-config=/usr/bin/php-config7.2 > /dev/null
make clean > /dev/null
make >/dev/null 2>&1
make install
chmod 644 /usr/lib/php/20160303/mongodb.so
bash -c "echo 'extension=mongodb.so' > /etc/php/7.2/mods-available/mongo.ini"
ln -s /etc/php/7.2/mods-available/mongo.ini /etc/php/7.2/cli/conf.d/20-mongo.ini
ln -s /etc/php/7.2/mods-available/mongo.ini /etc/php/7.2/fpm/conf.d/20-mongo.ini
systemctl restart php7.2-fpm

mongo admin --eval "db.createUser({user:'homestead',pwd:'secret',roles:['root']})"
