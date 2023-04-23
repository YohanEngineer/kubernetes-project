#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

WORKDIR=$(echo "${__dirname}")

cd "${WORKDIR}"

docker compose \
  --file compose.yaml \
  --project-name docker-registry \
  down

docker network rm docker-registry_network

docker rmi --force registry
docker rmi --force docker-registry-ui

docker image prune --force
docker network prune --force
docker volume prune --force
