FROM ubuntu:bionic

WORKDIR /app

RUN apt-get update && apt-get upgrade -y

#install supervisor, copy its config and create a symlink into mountdir
RUN apt-get update && apt-get install -y supervisor
COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ln -s /etc/supervisor/conf.d/ supervisor

CMD ["/usr/bin/supervisord"]