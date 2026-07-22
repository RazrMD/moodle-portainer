#!/usr/bin/env bash
set -euo pipefail

while true; do
  if [ -f /var/www/html/admin/cli/cron.php ] && [ -f /var/www/html/config.php ]; then
    php /var/www/html/admin/cli/cron.php || true
  fi
  sleep 60
done
