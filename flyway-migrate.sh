#! /usr/bin/bash

set -e # Exit on error
set -x # Print commands

DIR=$(dirname "$(readlink -f "$0")")
pushd $DIR

if command -v flyway >/dev/null 2>&1; then
	echo "flyway command found, using it"
	flyway migrate -configFiles=flyway.conf
else
	echo "flyway command not found, using docker"
	docker run --rm -it --network=host \
		-v $(pwd)/flyway-migrations:/flyway/flyway-migrations \
		-v $(pwd)/flyway.conf:/flyway/conf/flyway.conf \
		flyway/flyway:10.9 migrate
fi


popd
