#!/bin/sh
# Wait for ClickHouse, make sure the database exists, run the Postgres and
# ClickHouse migrations (retrying while the databases come up), then start.
set -u

: "${CLICKHOUSE_URL:?CLICKHOUSE_URL is required}"
CH_BASE="${CLICKHOUSE_URL%/*}"
CH_DB="${CLICKHOUSE_URL##*/}"
CH_DB="${CH_DB%%\?*}"

i=0
until curl -fsS "$CH_BASE/ping" >/dev/null 2>&1; do
  i=$((i + 1))
  [ "$i" -ge 60 ] && { echo "ClickHouse not reachable after 5 minutes"; exit 1; }
  echo "Waiting for ClickHouse..."; sleep 5
done
curl -fsS "$CH_BASE/" --data-binary "CREATE DATABASE IF NOT EXISTS \`$CH_DB\`" >/dev/null || true

cd /app/apps/api || exit 1
i=0
until CI=true pnpm -r run migrate:deploy; do
  i=$((i + 1))
  [ "$i" -ge 20 ] && { echo "Migrations failed 20 times, giving up"; exit 1; }
  echo "Migrations failed, retrying in 5 s..."; sleep 5
done

exec node dist/index.js
