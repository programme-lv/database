#!/bin/bash

trap "echo 'Interrupted! Exiting...'; exit 1" SIGINT SIGTERM

set -e # Exit immediately if a command exits with a non-zero status.
REPO_URL="https://github.com/programme-lv/database"
DEST_DIR="/tmp/proglv-database/repo"

git clone $REPO_URL $DEST_DIR

ls -l $DEST_DIR

DB_USER=$POSTGRES_USER
DB_NAME=$POSTGRES_DB

until pg_isready -U $DB_USER -d $DB_NAME -t 1; do
	echo >&2 "Postgres is unavailable - sleeping"
	sleep 1
done

FW_FLAGS="-url=jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
FW_FLAGS="$FW_FLAGS -user=$DB_USER -password=$DB_PASSWORD"
FW_FLAGS="$FW_FLAGS -locations=/flyway-migrations"

flyway $FW_FLAGS migrate
