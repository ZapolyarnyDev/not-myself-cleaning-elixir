import Config

config :not_myself_cleaning_elixir,
  ecto_repos: [NotMyselfCleaning.Repo]

config :not_myself_cleaning_elixir, NotMyselfCleaningWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: NotMyselfCleaningWeb.ErrorHTML],
    layout: false
  ],
  pubsub_server: NotMyselfCleaning.PubSub,
  live_view: [signing_salt: "random_salt"],
  secret_key_base:
    System.get_env(
      "SECRET_KEY_BASE",
      "dev_secret_key_base_for_local_not_myself_cleaning_elixir_only_64_bytes"
    ),
  http: [port: String.to_integer(System.get_env("PORT", "4000"))]

config :phoenix, :json_library, Jason

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{config_env()}.exs"
