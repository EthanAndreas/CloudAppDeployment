#!/bin/sh

# Generate random names

set -eu

for _i in $(seq 0 50); do
  ID=$(docker create nginx)
  docker inspect "$ID" --format '{{ .Name }}' | tr -d '/' | tr '_' '-'
  docker rm "$ID" > /dev/null
done
