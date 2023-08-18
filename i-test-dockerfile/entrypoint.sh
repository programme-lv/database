#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -t 1; do
	echo >&2 "Postgres is unavailable - sleeping"
	sleep 1
done

FW_FLAGS="-url=jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
FW_FLAGS="$FW_FLAGS -user=$DB_USER -password=$DB_PASSWORD"
FW_FLAGS="$FW_FLAGS -locations=filesystem:/flyway-migrations"

flyway $FW_FLAGS migrate
