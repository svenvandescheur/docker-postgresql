#!/bin/bash

# Docker entrypoint script
# Executes original command

# Summary:
# --------
# * Set up script
# * Start services
# * Execute command

# Set up script
set -e
set -o pipefail


# Start services
service rsyslog start
service cron start
service postfix start


# Execute command
if [[ $@ ]]
then
    exec "$@"
else
    chown -R postgres:postgres /srv//postgresql/
    chown -R postgres:postgres /var/run/postgresql/

    sudo postgres /usr/lib/postgresql/9.5/bin/postgres -D /srv/postgresql/main/
fi