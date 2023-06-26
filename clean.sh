#! /usr/bin/bash

docker run --rm -it --network=host -v $(pwd)/flyway-migrations:/flyway/flyway-migrations -v $(pwd)/flyway.conf:/flyway/conf/flyway.conf flyway/flyway:9.19 clean