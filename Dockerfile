FROM ubuntu:bionic

WORKDIR /apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y wget gnupg

# ########################## SUPERVISOR ##########################
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
RUN wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.15-1_all.deb
RUN apt-get update
#install mysql with blank root password
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
#create symlink from datadir into mountdir
RUN mkdir mysql && ln -s /var/lib/mysql/ mysql
RUN rm mysql-apt-config_0.8.15-1_all.deb

#mysql ports
EXPOSE 3306

CMD ["/usr/bin/supervisord"]