#!/usr/bin/env bash
set -euo pipefail

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_dir="/backups/${timestamp}"
mkdir -p "$backup_dir"

db_host="${MOODLE_DB_HOST:-mariadb}"
db_name="${MOODLE_DB_NAME:-moodle}"
db_user="${MOODLE_DB_USER:-moodle}"
db_password="${MOODLE_DB_PASSWORD:?MOODLE_DB_PASSWORD is required}"

mariadb-dump -h "$db_host" -u"$db_user" -p"$db_password" \
  --single-transaction \
  --quick \
  --routines \
  --triggers \
  "$db_name" | gzip -9 > "${backup_dir}/database.sql.gz"

tar -C "${MOODLE_DATAROOT:-/var/moodledata}" -czf "${backup_dir}/moodledata.tar.gz" .
tar -C /var/www/html -czf "${backup_dir}/moodle-app.tar.gz" config.php theme mod local blocks auth enrol filter repository 2>/dev/null || true

find /backups -mindepth 1 -maxdepth 1 -type d -mtime +"${BACKUP_RETENTION_DAYS:-14}" -exec rm -rf {} +

echo "Backup created: ${backup_dir}"
