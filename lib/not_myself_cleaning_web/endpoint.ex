defmodule NotMyselfCleaningWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :not_myself_cleaning_elixir

  @session_options [
    store: :cookie,
    key: "_not_myself_cleaning_key",
    signing_salt: System.get_env("SESSION_SIGNING_SALT", "dev_signing_salt"),
    same_site: "Lax"
  ]

  plug(Plug.Static,
    at: "/",
    from: :not_myself_cleaning_elixir,
    gzip: false,
    only: NotMyselfCleaningWeb.static_paths()
  )

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(Plug.Session, @session_options)
  plug(NotMyselfCleaningWeb.Router)
end
