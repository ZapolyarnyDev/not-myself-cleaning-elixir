defmodule NotMyselfCleaning.MixProject do
  use Mix.Project

  def project do
    [
      app: :not_myself_cleaning_elixir,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {NotMyselfCleaning.Application, []}
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7.14"},
      {:phoenix_ecto, "~> 4.6"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 1.0.0"},
      {:ecto_sql, "~> 3.13"},
      {:postgrex, "~> 0.20"},
      {:plug_cowboy, "~> 2.7"},
      {:jason, "~> 1.4"}
    ]
  end
end
