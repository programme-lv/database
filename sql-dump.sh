#! /usr/bin/bash

set -ex # Exit on error and print commands

# Define variables
DB_CONTAINER_NAME="postgres_db_2"
DB_NAME="second_database"
DB_USER="postgres"
DB_PASSWORD="yourpassword"
DUMP_FILE="database_dump.sql"

# Function to check if a container is already running
is_container_running() {
    local container_name="$1"
    docker ps -q -f name="$container_name" | grep -q .
}

# Function to create a new PostgreSQL container
create_postgres_container() {
    local container_name="$1"
    local db_name="$2"
    local db_user="$3"
    local db_password="$4"

    docker run -d \
        --name "$container_name" \
        -e POSTGRES_DB="$db_name" \
        -e POSTGRES_USER="$db_user" \
        -e POSTGRES_PASSWORD="$db_password" \
        -p 5433:5432 \
        postgres:latest
}

# Function to wait for PostgreSQL to be ready
wait_for_postgres() {
    local container_name="$1"
    until docker exec "$container_name" pg_isready -U "$DB_USER"; do
        echo "Waiting for PostgreSQL to be ready..."
        sleep 2
    done
}

# Check if the container is already running
if is_container_running "$DB_CONTAINER_NAME"; then
    echo "Container $DB_CONTAINER_NAME is already running."
else
    # Create and start the PostgreSQL container
    create_postgres_container "$DB_CONTAINER_NAME" "$DB_NAME" "$DB_USER" "$DB_PASSWORD"
    echo "Created and started container $DB_CONTAINER_NAME."
fi

# Wait for PostgreSQL to be ready
wait_for_postgres "$DB_CONTAINER_NAME"
echo "PostgreSQL is ready."

# Run Flyway migration
docker run --rm -it --network=host \
    -v "$(pwd)"/flyway-migrations:/flyway/flyway-migrations \
    flyway/flyway:latest migrate \
    -url="jdbc:postgresql://localhost:5433/$DB_NAME" \
    -user="$DB_USER" -password="$DB_PASSWORD" \
    -locations="filesystem:/flyway/flyway-migrations"
echo "Flyway migration completed."

# Dump the database to a file
docker exec -t "$DB_CONTAINER_NAME" pg_dump -U "$DB_USER" "$DB_NAME" > "$DUMP_FILE"
echo "Database dump completed. Dump file: $DUMP_FILE"
