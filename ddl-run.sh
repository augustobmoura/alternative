#! /usr/bin/env bash

set -euxv

(
	cd /srv/ddl

	for sql in $(find . -name '*.sql' | sed 's/\.\///g' | sort -V); do
		psql -v "authenticatorPass=$AUTHENTICATOR_PASSWORD" --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < "$sql"
	done
)
