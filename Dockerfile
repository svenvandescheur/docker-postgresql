FROM svenv/base
MAINTAINER Sven van de Scheur <svenvandescheur@gmail.com>

# Add file tree
ADD files /

# Install required packages
RUN apt-get update && apt-get install -y \
    postgresql && \

    echo host all all all md5 >> /etc/postgresql/9.5/main/pg_hba.conf && \
    echo local all all trust >> /etc/postgresql/9.5/main/pg_hba.conf && \

    mkdir -p /srv/postgresql/main/ && \
    chown -R postgres:postgres /srv/postgresql/main/

# Expose
EXPOSE 5432