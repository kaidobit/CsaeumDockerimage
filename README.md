# CsaeumDockerimage
Dockerimage requested by Csaeum

This image has a mainprocess, which starts and keeps track of all services used by Csaeum.

## Supervisor
Supervisor is the mainprocess which starts, tracks and gracefully stops all services configured in supervisord.conf.

Documentation: http://supervisord.org/introduction.html

Configuration Reference: http://supervisord.org/configuration.html

## Services beeing started
### MySQL
Version: 8.0.21

Data-Dir:

### Elasticsearch
Version: 2.4.6

### Apache2
Verison: 2.4.29

Document-Root: *MOUNTDIR*/apache2/document_root

### Memcached
Version: 1.5.6

### PHP
Version: 7.4.10

Config-Dir:


