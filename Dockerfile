FROM ubuntu:bionic

WORKDIR /apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y wget gnupg

# ########################## Supervisor ##########################
#install supervisor
RUN apt-get update && apt-get install -y supervisor
#copy its config
COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#and create a symlink into mountdir
RUN ln -s /etc/supervisor/conf.d/ supervisor

# ########################## MySQL ##########################
#install mysql dependencies
RUN apt-get update && apt-get install -y lsb-release
#add mysql-ppa (ubuntu ppa provides only mysql 5.7)
RUN wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb && \
DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.15-1_all.deb
#install mysql with blank root password
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
#create symlink from datadir into mountdir
RUN ln -s /var/lib/mysql/ mysql

# ########################## Elasticsearch ##########################
#install dependencies
RUN apt-get update && apt-get install -y openjdk-8-jre
#add elasticsearch-ppa
RUN wget https://packages.elastic.co/GPG-KEY-elasticsearch && \
apt-key add GPG-KEY-elasticsearch && \
echo  "deb  http://packages.elastic.co/elasticsearch/2.x/debian stable main" | \
tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
#install elasticsearch
RUN apt-get update && apt-get install -y elasticsearch
#create symlinks in mountdir
RUN mkdir elasticsearch && cd elasticsearch && \
ln -s /etc/elasticsearch/ conf && \
ln -s /var/lib/elasticsearch/ data && \
ln -s /var/log/elasticsearch/ logs && \
ln -s /usr/share/elasticsearch/ home

# ########################## Apache ##########################
#install apache2
RUN apt-get install -y apache2
#create symlinks in mountdir
RUN mkdir apache2 && cd apache2 && \
ln -s /var/www/html/ document_root && \
ln -s /etc/apache2/ conf

# ########################## Memcached ##########################
#install memcached
RUN apt-get update && apt-get install -y memcached libmemcached-tools
#create symlink in mountdir
RUN mkdir memcached && ln -s /etc/memcached.conf memcached/memcached.conf

# ########################## PHP ##########################
#add ondrej-ppa for php 7.4
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
#install php and appache's php module
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y php7.4 libapache2-mod-php7.4 php-memcached php7.4-cli
#create symlink in mountdir
RUN ln -s /etc/php/7.4/apache2 php

# ########################## cleanup ##########################
RUN rm GPG-KEY-elasticsearch && \
rm mysql-apt-config_0.8.15-1_all.deb && \
apt-get purge wget

#mysql
EXPOSE 3306
#elasticsearch
EXPOSE 9200
#apache2
EXPOSE 80
#memcached
EXPOSE 11211

CMD ["/usr/bin/supervisord"]