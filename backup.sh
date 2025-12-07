#!/usr/bin/env bash

set -e

DATE=$(date +%Y-%m-%d)
BACKUP_DIR="./backups/$DATE"

echo "📦 Creating backup: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

echo "⏳ Backing up NPM data volume..."
docker run --rm \
  -v volume-nginx-proxy-manager-data:/data \
  -v "$BACKUP_DIR:/backup" \
  busybox sh -c "cp -r /data /backup/data"

echo "⏳ Backing up SSL certificates..."
docker run --rm \
  -v volume-nginx-proxy-manager-ssl:/data \
  -v "$BACKUP_DIR:/backup" \
  busybox sh -c "cp -r /data /backup/letsencrypt"

echo "📦 Compressing backup..."
cd backups
tar -czf "${DATE}.tar.gz" "$DATE"
cd ..

echo "🎉 Backup complete!"
echo "Backup saved at: backups/${DATE}.tar.gz"
