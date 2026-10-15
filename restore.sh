#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 || ! -f "$1" ]]; then
    echo 'Utilizare: bash restore.sh backups/nume.dump' >&2
    exit 1
fi
export PGHOST="${PGHOST:-127.0.0.1}" PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-library_owner}"
# Destinație fixă: baza separată de test, creată în prealabil.
pg_restore --dbname=library_restore --no-owner --no-privileges --single-transaction --exit-on-error "$1"
psql -X --dbname=library_restore -v ON_ERROR_STOP=1 -f "$(dirname "$0")/verify.sql"
