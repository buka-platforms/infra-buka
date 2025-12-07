#!/usr/bin/env bash

set -e

echo "🚀 Deploying Nginx Proxy Manager..."

# Validate compose file
docker compose config > /dev/null

# Build and run
docker compose up -d --force-recreate --build --remove-orphans

echo "✅ Deployment complete!"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
