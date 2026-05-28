defmodule NotMyselfCleaningWeb.Router do
  @moduledoc false

  use Plug.Router

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Static,
    at: "/assets",
    from: {:not_myself_cleaning_elixir, "priv/static/assets"},
    gzip: false

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("text/html; charset=utf-8")
    |> send_resp(200, NotMyselfCleaningWeb.PageHTML.home())
  end

  get "/health" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  match _ do
    conn
    |> put_resp_content_type("text/plain; charset=utf-8")
    |> send_resp(404, "Not found")
  end
end
