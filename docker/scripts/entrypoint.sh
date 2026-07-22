#!/usr/bin/env bash
set -euo pipefail

if [ ! -f /var/www/html/version.php ]; then
  cp -a /usr/src/moodle/. /var/www/html/
fi

mkdir -p "${MOODLE_DATAROOT:-/var/moodledata}"
chown -R www-data:www-data /var/www/html "${MOODLE_DATAROOT:-/var/moodledata}"

wait-for-db

if [ ! -f /var/www/html/config.php ] && [ -f /usr/local/share/moodle/config.php.template ]; then
  envsubst '${MOODLE_DB_HOST} ${MOODLE_DB_NAME} ${MOODLE_DB_USER} ${MOODLE_DB_PASSWORD} ${MOODLE_WWWROOT} ${MOODLE_DATAROOT} ${MOODLE_REDIS_HOST}' \
    < /usr/local/share/moodle/config.php.template > /var/www/html/config.php
  chown www-data:www-data /var/www/html/config.php
  chmod 0640 /var/www/html/config.php
fi

moodle-install

exec "$@"
