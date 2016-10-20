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

    service postgresql start || exit 1
    tail -fn 0 /var/log/postgresql/postgresql-9.5-main.log
fi