
{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    erlang
    elixir
    beamPackages.hex
    beamPackages.rebar3

    nodejs_22
    pnpm

    inotify-tools

    elixir-ls

    nil
    nixfmt-rfc-style

    postgresql_18
    sqlite

    just
    git
    jq
  ];

  shellHook = ''
    export PGDATA="$PWD/.data/postgres"
    export PGHOST="$PWD/.data/postgres"
    export PGPORT="54329"
    export DATABASE_URL="postgresql://localhost:$PGPORT/app"

    mkdir -p "$PGHOST"

    echo "Dev shell loaded"
    echo "DATABASE_URL=$DATABASE_URL"
    echo "***********************************"
    echo "Commands:"
    echo " just db-init"
    echo " just db-start"
    echo " just db-stop"
    echo " just db-reset"
  '';
}
