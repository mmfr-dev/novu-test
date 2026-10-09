#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "${SCRIPT_DIR}/init"

MONGO_URL="mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@mongodb:27017/novu-db?authSource=admin"

docker exec novu-mongodb mongodump \
    --uri="${MONGO_URL}" \
    --gzip \
    --archive="/tmp/novu-backup.gz"

docker cp \
    novu-mongodb:/tmp/novu-backup.gz \
    "${SCRIPT_DIR}/init/novu-backup.gz"