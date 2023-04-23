#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

WORKDIR=$(echo "${__dirname}")

cd "${WORKDIR}"

docker compose \
  --file compose.yaml \
  --project-name docker-registry \
  down
