FROM ubuntu:bionic

WORKDIR /apps

RUN apt-get update && apt-get upgrade -y

#install dependencies
RUN apt-get update && apt-get install -y \
wget lsb-release openjdk-8-jre software-properties-common gnupg

#add repositories
#add mysql-ppa (ubuntu ppa provides only mysql 5.7)
RUN wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb && \
DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.15-1_all.deb && \
#add elasticsearch-ppa
wget https://packages.elastic.co/GPG-KEY-elasticsearch && \
apt-key add GPG-KEY-elasticsearch && \
echo  "deb  http://packages.elastic.co/elasticsearch/2.x/debian stable main" | \
tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list && \
#add ondrej-ppa for php 7.4
add-apt-repository ppa:ondrej/php

#install services
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
supervisor mysql-server elasticsearch apache2 memcached libmemcached-tools \
php7.4 libapache2-mod-php7.4 php-memcached php7.4-cli

#cleanup
RUN rm GPG-KEY-elasticsearch && \
rm mysql-apt-config_0.8.15-1_all.deb && \
apt-get purge -y wget

#manage configs
COPY configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY configs/php.ini /etc/php/7.4/apache2/php.ini
COPY configs/memcached.conf /etc/memcached.conf
COPY configs/apache2.conf /etc/apache2/apache2.conf

#manage data
RUN ln -s /var/www/html/ document_root && \
ln -s /var/lib/mysql/ mysql

#mysql
EXPOSE 3306
#elasticsearch
EXPOSE 9200
#apache2
EXPOSE 80
#memcached
EXPOSE 11211

CMD ["/usr/bin/supervisord"]