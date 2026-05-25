import Config

config :not_myself_cleaning_elixir, NotMyselfCleaning.Repo,
  url:
    System.get_env(
      "DATABASE_URL",
      "postgres://postgres:postgres@localhost/not_myself_cleaning_dev"
    ),
  pool_size: 10,
  show_sensitive_data_on_connection_error: true

config :not_myself_cleaning_elixir, NotMyselfCleaningWeb.Endpoint,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []
