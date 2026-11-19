#!/bin/sh
set -eu

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -v site_password="$SITE_DB_PASSWORD" \
  -v api_password="$API_DB_PASSWORD" <<'SQL'
ALTER ROLE rwz_site LOGIN PASSWORD :'site_password';
ALTER ROLE rwz_api LOGIN PASSWORD :'api_password';
SQL
