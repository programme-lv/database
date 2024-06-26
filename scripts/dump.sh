#!/bin/bash
set -ex # Exit on error, print each command

SCRIPT_DIR=$(dirname "$0")

prompt_values() {
    PGHOST=$(zenity --entry --title="PostgreSQL Host" --text="Enter the PostgreSQL host:")
    PGPORT=$(zenity --entry --title="PostgreSQL Port" --text="Enter the PostgreSQL port:")
    PGUSER=$(zenity --entry --title="PostgreSQL Username" --text="Enter the PostgreSQL username:")
    PGPASSWORD=$(zenity --password --title="PostgreSQL Password" --text="Enter the PostgreSQL password:")
    PGDATABASE=$(zenity --entry --title="PostgreSQL Database" --text="Enter the PostgreSQL database name:")
}

prompt_values

pushd "$SCRIPT_DIR/../dumps"

# Dump the production database
PGPASSWORD=$PGPASSWORD pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -F c -b -v -f prod-db.dump

popd

zenity --info --title="Operation Complete" --text="Database dump complete. The dump file is saved as prod-db.dump."