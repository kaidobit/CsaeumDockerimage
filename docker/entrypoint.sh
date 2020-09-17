#!/bin/bash

#create symlink from mountdir to targetdir for
#php
ln -s /apps/configs/php.ini /etc/php/7.4/apache2/php.ini
#memcached
ln -s /apps/configs/memcached.conf /etc/memcached.conf
#apache2
ln -s /apps/configs/apache2.conf /etc/apache2/apache2.conf

supervisord -n