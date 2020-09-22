# CsaeumDockerimage
Dockerimage requested by Csaeum



## Usage
###Environment Variables
DB_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default: db\
Name of the Database which is initially created.

DB_ADMIN_USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default: admin\
Username of the Adminuser which is initially created.

DB_ADMIN_PASSWORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default: admin\
Password of the Adminuser which is initially created.

DB_ROOT_PASSWORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default: root\
Password of the root-user.

###MountPoints
**/apps/document_root** is apache2's documentRoot.
**/apps/mysql** is mysql's data directory.

###Recommendation
First create two docker volumes.\

`docker volume create mysql && docker volume create document_root`

Than get their Mountpoint.\

`docker volume inspect mysql | grep Mountpoint && docker volume inspect document_root | grep Mountpoint`

**[OPTIONAL]** Create the symlinks.\

`<MOUNTPOINT>` = the mountpoint from last command\
`<DIRECTORY>` = the symlink, it can be whereever you want\

`ln -s <MOUNTPOINT> <DIRECTORY>`

Now we can start the container.\

`docker run -P -v document_root:/apps/document_root -v mysql:/var/lib/mysql/ <TAG>`\

Where `<TAG>` is the tag you provided by building the image.

## Build
Build the image using\

`docker build --tag <TAG> <DOCKERFILE>`\

Where `<TAG>` is the tag you want to use (`<NAME>:<VERSION>`) and
`<DOCKERFILE>` is the path of the dockerfile.

## Services beeing started
### Supervisor
Supervisor is the mainprocess which starts, tracks and gracefully stops all services,
configured in supervisord.conf.

### MySQL
Version: 8.0.21

Datadirectory: /apps/mysql

### Elasticsearch
Version: 2.4.6

### Apache2
Verison: 2.4.29

DocumentRootDirectory: /apps/document_root

### Memcached
Version: 1.5.6

### PHP
Version: 7.4.10


