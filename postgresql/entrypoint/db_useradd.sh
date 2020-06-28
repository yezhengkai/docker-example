#!/bin/bash
# References:
# https://www.intricatecloud.io/2018/11/managing-db-users-in-postgres-mysql/
# https://github.com/pgsql-tw/gitbook-docs/tree/master/tw
# https://github.com/docker-library/docs/blob/master/postgres/README.md#supported-tags-and-respective-dockerfile-links
# https://myapollo.com.tw/zh-tw/docker-postgres/
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# https://github.com/MartinKaburu/docker-postgresql-multiple-databases


set -e

# If the redirection operator is ‘<<-’, then all leading tab characters are stripped from input lines and the line containing delimiter.
# This allows here-documents within shell scripts to be indented in a natural fashion. 
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

    CREATE USER cgrguser1 WITH PASSWORD 'cgrguser1Pass';
    CREATE USER cgrguser2 WITH PASSWORD 'cgrguser2Pass';
    CREATE DATABASE cgrgdb;
    GRANT ALL PRIVILEGES ON DATABASE cgrgdb TO cgrguser1, cgrguser2;

EOSQL
