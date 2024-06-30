#!/bin/bash
set -ex # Exit on error

SCRIPT_DIR=$(dirname "$0")

# Function to prompt for input values using zenity
prompt_values() {
    LOCAL_DB_USER=$(zenity --entry --title="Local Docker PostgreSQL Username" --text="Enter the local Docker PostgreSQL username:")
    LOCAL_DB_NAME=$(zenity --entry --title="Local Docker PostgreSQL Database" --text="Enter the local Docker PostgreSQL database name:")
    LOCAL_DB_PASSWORD=$(zenity --password --title="Local Docker PostgreSQL Password" --text="Enter the local Docker PostgreSQL password:")
}

# Function to check if a Docker container exists and is running
check_docker_container() {
    CONTAINER_EXISTS=$(docker ps -a --format '{{.Names}}' | grep -w local-postgres || echo "false")
    if [ "$CONTAINER_EXISTS" == "false" ]; then
        echo "Docker container 'local-postgres' does not exist. Creating and starting the container..."
        docker run --name local-postgres -p 5432:5432 -e POSTGRES_USER=$LOCAL_DB_USER -e POSTGRES_PASSWORD=$LOCAL_DB_PASSWORD -d postgres:16.3
        # Wait for the container to be fully started
        sleep 10
    else
        RUNNING=$(docker inspect --format="{{.State.Running}}" local-postgres)
        if [ "$RUNNING" != "true" ]; then
            echo "Docker container 'local-postgres' is not running. Starting the container..."
            docker start local-postgres
            # Wait for the container to be fully started
            sleep 10
        else
            echo "Docker container 'local-postgres' is already running."
        fi
    fi
}

# Function to wait until PostgreSQL inside the container is ready
wait_for_postgres() {
    echo "Waiting for PostgreSQL to be ready..."
    until docker exec -it local-postgres pg_isready -U $LOCAL_DB_USER; do
        sleep 2
    done
    echo "PostgreSQL is ready."
}

# Main script
prompt_values

check_docker_container
wait_for_postgres

# Prune the local database (drop and recreate)
docker exec -it local-postgres psql -U $LOCAL_DB_USER -d postgres -c "DROP DATABASE IF EXISTS $LOCAL_DB_NAME;"
docker exec -it local-postgres psql -U $LOCAL_DB_USER -d postgres -c "CREATE DATABASE $LOCAL_DB_NAME;"

# Load the dump into the local database
pushd "$SCRIPT_DIR/../dumps"
docker cp prod-db.dump local-postgres:/prod-db.dump
popd

docker exec -it local-postgres pg_restore -U $LOCAL_DB_USER -d $LOCAL_DB_NAME -v /prod-db.dump

zenity --info --title="Operation Complete" --text="Database setup and import complete."
