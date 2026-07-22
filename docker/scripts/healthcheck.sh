#!/usr/bin/env bash
set -euo pipefail

if [ ! -f /var/www/html/version.php ]; then
  exit 1
fi

if [ ! -f /var/www/html/config.php ]; then
  exit 1
fi

curl -fsS http://127.0.0.1/login/index.php >/dev/null
