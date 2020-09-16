# CsaeumDockerimage
Dockerimage requested by Csaeum

This image has a mainprocess, which starts and keeps track of all services used by Csaeum.

## Supervisor
Supervisor is the mainprocess which starts, tracks and gracefully stops all services configured in supervisord.conf.

Config-File: *MOUNTDIR*/supervisor/supervisord.conf

Documentation: http://supervisord.org/introduction.html
Configuration Reference: http://supervisord.org/configuration.html

## Services beeing started
### MySQL
Version: 8.0.21

Data-Dir: *MOUNTDIR*/mysql

### Elasticsearch
Version: 2.4.6

Data-Dir: *MOUNTDIR*/elasticsearch/data

Config-Dir: *MOUNTDIR*/elasticsearch/conf

Log-Dir: *MOUNTDIR*/elasticsearch/logs

Home-Dir: *MOUNTDIR*/elasticsearch/home

###Apache2
Verison: 2.4.29

Document-Root: *MOUNTDIR*/apache2/document_root

Conf-Dir: *MOUNTDIR*/apache2/conf
