#!/usr/bin/env bash
set -euo pipefail

db_host="${MOODLE_DB_HOST:-mariadb}"
db_name="${MOODLE_DB_NAME:-moodle}"
db_user="${MOODLE_DB_USER:-moodle}"
db_password="${MOODLE_DB_PASSWORD:?MOODLE_DB_PASSWORD is required}"

is_installed() {
  mariadb -h "$db_host" -u"$db_user" -p"$db_password" "$db_name" \
    -NBe "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${db_name}' AND table_name='mdl_config';" 2>/dev/null \
    | grep -q '^1$'
}

if is_installed; then
  exit 0
fi

if [ -z "${MOODLE_ADMIN_PASSWORD:-}" ]; then
  echo "Moodle database is empty and MOODLE_ADMIN_PASSWORD is not set."
  echo "Open the site and complete the web installer, or set MOODLE_ADMIN_PASSWORD for unattended install."
  exit 0
fi

php_admin() {
  su -s /bin/sh www-data -c "php $*"
}

php_admin "/var/www/html/admin/cli/install_database.php \
  --agree-license \
  --adminuser='${MOODLE_ADMIN_USER:-admin}' \
  --adminpass='${MOODLE_ADMIN_PASSWORD}' \
  --adminemail='${MOODLE_ADMIN_EMAIL:-admin@example.com}' \
  --fullname='${MOODLE_SITE_FULLNAME:-Moodle LMS}' \
  --shortname='${MOODLE_SITE_SHORTNAME:-Moodle}'"

php_admin "/var/www/html/admin/cli/cfg.php --name=timezone --set='${MOODLE_TIMEZONE:-Europe/Chisinau}'" || true
php_admin "/var/www/html/admin/cli/cfg.php --name=slasharguments --set=1" || true
