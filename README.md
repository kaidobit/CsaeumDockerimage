# CsaeumDockerimage
Dockerimage requested by Csaeum

This image has a mainprocess, which starts and keeps track of all services used by Csaeum.

## Supervisor
Supervisor is the mainprocess which starts, tracks and gracefully stops all services configured in supervisord.conf.

Config-File: <MOUNTDIR>/supervisor/supervisord.conf

Documentation: http://supervisord.org/introduction.html
Configuration Reference: http://supervisord.org/configuration.html