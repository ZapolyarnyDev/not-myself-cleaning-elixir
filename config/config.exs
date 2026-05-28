import Config

config :not_myself_cleaning_elixir,
  ecto_repos: [NotMyselfCleaning.Repo],
  web_server: config_env() != :test

config :not_myself_cleaning_elixir, NotMyselfCleaningWeb.Endpoint,
  port: String.to_integer(System.get_env("PORT", "4000"))

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{config_env()}.exs"
