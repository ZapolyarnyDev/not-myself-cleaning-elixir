defmodule NotMyselfCleaning.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      []
      |> maybe_start_repo()
      |> maybe_start_web_server()

    opts = [strategy: :one_for_one, name: NotMyselfCleaning.Supervisor]

    Supervisor.start_link(children, opts)
  end

  defp maybe_start_repo(children) do
    repo_config = Application.get_env(:not_myself_cleaning_elixir, NotMyselfCleaning.Repo, [])

    case Keyword.get(repo_config, :url) do
      url when is_binary(url) and url != "" -> children ++ [NotMyselfCleaning.Repo]
      _ -> children
    end
  end

  defp maybe_start_web_server(children) do
    if Application.get_env(:not_myself_cleaning_elixir, :web_server, true) do
      endpoint_config =
        Application.fetch_env!(:not_myself_cleaning_elixir, NotMyselfCleaningWeb.Endpoint)

      children ++
        [
          {Plug.Cowboy,
           scheme: :http,
           plug: NotMyselfCleaningWeb.Router,
           options: [port: Keyword.fetch!(endpoint_config, :port)]}
        ]
    else
      children
    end
  end
end
