#!/usr/bin/env bash
set -euo pipefail

host="${MOODLE_DB_HOST:-mariadb}"
user="${MOODLE_DB_USER:-moodle}"
password="${MOODLE_DB_PASSWORD:?MOODLE_DB_PASSWORD is required}"

until mariadb-admin ping -h "$host" -u"$user" -p"$password" --silent; do
  sleep 3
done
