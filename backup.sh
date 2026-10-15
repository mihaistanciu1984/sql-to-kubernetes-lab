#!/usr/bin/env bash
set -euo pipefail
umask 077
export PGHOST="${PGHOST:-127.0.0.1}" PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-library_owner}" PGDATABASE="${PGDATABASE:-library_lab}"
mkdir -p backups
output=$(mktemp "backups/library-$(date +%Y%m%d-%H%M%S)-XXXXXX.dump")
if ! pg_dump --format=custom --file="$output"; then
    rm -f -- "$output"
    echo 'Backup esuat.' >&2
    exit 1
fi
pg_restore --list "$output" >/dev/null
printf 'Backup creat: %s\n' "$output"
