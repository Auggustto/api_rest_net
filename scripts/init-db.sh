#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

docker build \
  -f "$ROOT_DIR/Dockerfile/dockerfile-mysql" \
  -t meu-mysql \
  "$ROOT_DIR"

  docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  meu-mysql