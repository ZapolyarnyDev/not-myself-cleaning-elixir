import Config

config :not_myself_cleaning_elixir, NotMyselfCleaning.Repo,
  url: System.fetch_env!("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10"))
