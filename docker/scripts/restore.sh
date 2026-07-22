#!/usr/bin/env bash
set -euo pipefail

backup_dir="${1:-}"
if [ -z "$backup_dir" ] || [ ! -d "$backup_dir" ]; then
  echo "Usage: moodle-restore /backups/YYYYMMDDTHHMMSSZ"
  exit 2
fi

db_host="${MOODLE_DB_HOST:-mariadb}"
db_name="${MOODLE_DB_NAME:-moodle}"
db_user="${MOODLE_DB_USER:-moodle}"
db_password="${MOODLE_DB_PASSWORD:?MOODLE_DB_PASSWORD is required}"

if [ ! -f "${backup_dir}/database.sql.gz" ] || [ ! -f "${backup_dir}/moodledata.tar.gz" ]; then
  echo "Backup is incomplete: ${backup_dir}"
  exit 2
fi

dataroot="${MOODLE_DATAROOT:-/var/moodledata}"
if [ "$dataroot" = "/" ] || [ -z "$dataroot" ]; then
  echo "Refusing to restore into unsafe dataroot: ${dataroot}"
  exit 2
fi

gzip -dc "${backup_dir}/database.sql.gz" | mariadb -h "$db_host" -u"$db_user" -p"$db_password" "$db_name"

find "$dataroot" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
tar -C "$dataroot" -xzf "${backup_dir}/moodledata.tar.gz"

if [ -f "${backup_dir}/moodle-app.tar.gz" ]; then
  tar -C /var/www/html -xzf "${backup_dir}/moodle-app.tar.gz"
fi

chown -R www-data:www-data /var/www/html "$dataroot"
echo "Restore completed from: ${backup_dir}"
