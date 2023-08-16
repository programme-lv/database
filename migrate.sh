#! /usr/bin/bash

set -e # Exit on error

DIR=$(dirname "$(readlink -f "$0")")
pushd $DIR

docker run --rm -it --network=host \
	-v $(pwd)/flyway-migrations:/flyway/flyway-migrations \
	-v $(pwd)/flyway.conf:/flyway/conf/flyway.conf \
	flyway/flyway:9.21 migrate

popd
