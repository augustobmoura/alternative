FROM postgres:12.1-alpine

COPY ddl-run.sh /docker-entrypoint-initdb.d/ddl-run.sh

COPY ddl/1.0.0.sql /srv/ddl/1.0.0.sql
