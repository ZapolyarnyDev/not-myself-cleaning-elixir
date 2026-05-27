set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

db-init:
  initdb "$PGDATA"

db-start:
  pg_ctl -D "$PGDATA" -l "$PGDATA/log" -o "-k $PGHOST -p $PGPORT" start
  createdb -h "$PGHOST" -p "$PGPORT" app || true

db-stop:
  pg_ctl -D "$PGDATA" stop

db-reset:
  rm -rf .data/postgres
  just db-init
  just db-start
