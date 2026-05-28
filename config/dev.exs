import Config

config :not_myself_cleaning_elixir, NotMyselfCleaning.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10
