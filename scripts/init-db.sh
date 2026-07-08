#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Carregar o .env no shell ANTES de usar as variáveis
if [ -f "$ROOT_DIR/.env" ]; then
  set -a
  source "$ROOT_DIR/.env"
  set +a
  echo "Variáveis do .env carregadas"
else
  echo "Arquivo .env não encontrado em $ROOT_DIR"
  exit 1
fi

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
  --env-file "$ROOT_DIR/.env" \
  meu-mysql

export ConnectionStrings__DefaultConnection="Server=${MYSQL_HOST};Port=3306;Database=${MYSQL_DATABASE};User=${MYSQL_USER};Password=${MYSQL_PASSWORD};"

echo ""
echo "Connection string exportada:"
echo "   Server=${MYSQL_HOST};Port=3306;Database=${MYSQL_DATABASE};User=${MYSQL_USER};Password=***"

echo ""
echo "Aguardando MySQL inicializar (15s)..."
sleep 15

echo ""
echo " Testando conexão com o banco..."
docker exec mysql-container mysql \
  -u"${MYSQL_USER}" \
  -p"${MYSQL_PASSWORD}" \
  -e "SELECT 'Conexão OK' AS status;" \
  "${MYSQL_DATABASE}" && echo "MySQL respondendo!" || echo "Falha na conexão"