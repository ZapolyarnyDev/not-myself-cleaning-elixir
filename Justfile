set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

default:
  @just --list

setup:
  mix deps.get

format:
  mix format

test:
  mix test

check:
  mix format --check-formatted
  mix test

server:
  mix phx.server

console:
  iex -S mix phx.server

compile:
  mix compile

clean:
  mix clean

db-create:
  mix ecto.create

db-drop:
  mix ecto.drop

db-migrate:
  mix ecto.migrate

db-rollback:
  mix ecto.rollback

db-rollback-all:
  mix ecto.rollback --all

db-reset:
  mix ecto.reset

db-status:
  mix ecto.migrations

db-gen-migration name:
  mix ecto.gen.migration {{name}}

init:
  just setup
  just db-create
  just db-migrate

deps-update:
  mix deps.update --all

deps-outdated:
  mix hex.outdated

routes:
  mix phx.routes

test-coverage:
  mix test --cover

db-init:
  initdb "$PGDATA"

db-start:
  pg_ctl -D "$PGDATA" -l "$PGDATA/log" -o "-k $PGHOST -p $PGPORT" start
  createdb -h "$PGHOST" -p "$PGPORT" app || true

db-stop:
  pg_ctl -D "$PGDATA" stop

db-local-reset:
  rm -rf .data/postgres
  just db-init
  just db-start
