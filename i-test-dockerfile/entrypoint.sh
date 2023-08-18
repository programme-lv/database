#!/bin/bash

trap "echo 'Interrupted! Exiting...'; exit 1" SIGINT SIGTERM

set -e # Exit immediately if a command exits with a non-zero status.
REPO_URL="https://github.com/programme-lv/database"
DEST_DIR="/tmp/proglv-database/repo"

git clone $REPO_URL $DEST_DIR

ls -l $DEST_DIR

DB_USER=$POSTGRES_USER
DB_NAME=$POSTGRES_DB
DB_PASSWORD=$POSTGRES_PASSWORD

# ip route | awk '/default/ { print $3 }'
HOST_IP=$(ip route | awk '/default/ { print $3 }')
echo "HOST_IP=$HOST_IP"

until pg_isready -h $HOST_IP -U $DB_USER -d $DB_NAME -t 1; do
	echo >&2 "Postgres is unavailable - sleeping"
	sleep 1
done

# ls -al /flyway-migrations

FW_FLAGS="-url=jdbc:postgresql://$HOST_IP:5432/$DB_NAME"
FW_FLAGS="$FW_FLAGS -user=$DB_USER -password=$DB_PASSWORD"
FW_FLAGS="$FW_FLAGS -locations=/flyway-migrations"

ip a

flyway $FW_FLAGS migrate
