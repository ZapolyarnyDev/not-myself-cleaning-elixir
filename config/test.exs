import Config

config :not_myself_cleaning_elixir, NotMyselfCleaning.Repo,
  url: System.get_env("TEST_DATABASE_URL"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 5
