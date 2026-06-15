#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

docker build \
  --no-cache \
  -f "$ROOT_DIR/Dockerfile/dockerfile-mysql" \
  -t meu-mysql \
  "$ROOT_DIR"

if docker ps -a --format '{{.Names}}' | grep -q '^mysql-container$'; then
    echo "Container mysql-container encontrado. Removendo..."
    docker rm -f mysql-container
fi

docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  meu-mysql