defmodule NotMyselfCleaning.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NotMyselfCleaning.Repo,
      {Phoenix.PubSub, name: NotMyselfCleaning.PubSub},
      NotMyselfCleaningWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: NotMyselfCleaning.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
