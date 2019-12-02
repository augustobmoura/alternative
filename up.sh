#! /usr/bin/env sh

set -e

export AUTHENTICATOR_PASSWORD=123
export DB_SUPER_PASSWORD=123

docker-compose build --build-arg AUTHENTICATOR_PASSWORD="$AUTHENTICATOR_PASSWORD" --build-arg DB_SUPER_PASSWORD="$DB_SUPER_PASSWORD"
docker-compose up -V
