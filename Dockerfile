FROM ubuntu:bionic

WORKDIR /app

RUN apt-get update && apt-get upgrade -y

#install supervisor, copy its config and create a symlink into mountdir
RUN apt-get update && apt-get install -y supervisor
COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ln -s /etc/supervisor/conf.d/ supervisor

#install mysql dependencies, add mysql-ppa (ubuntu ppa provides only mysql 5.7),
#install mysql with blank root password, create symlink from datadir into mountdir
RUN apt-get update && apt-get install -y wget lsb-release gnupg
RUN wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.15-1_all.deb
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN mkdir mysql && ln -s /var/lib/mysql/ mysql

#mysql ports
EXPOSE 3306

CMD ["/usr/bin/supervisord"]