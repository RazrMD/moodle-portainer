#!/usr/bin/env bash
set -euo pipefail

if [ ! -f /var/www/html/version.php ]; then
  cp -a /usr/src/moodle/. /var/www/html/
fi

mkdir -p "${MOODLE_DATAROOT:-/var/moodledata}"
chown -R www-data:www-data /var/www/html "${MOODLE_DATAROOT:-/var/moodledata}"

if [ ! -f /var/www/html/config.php ] && [ -f /usr/local/share/moodle/config.php.template ]; then
  envsubst < /usr/local/share/moodle/config.php.template > /var/www/html/config.php
  chown www-data:www-data /var/www/html/config.php
  chmod 0640 /var/www/html/config.php
fi

exec "$@"
