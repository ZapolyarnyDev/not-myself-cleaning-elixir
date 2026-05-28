defmodule NotMyselfCleaning.Repo do
  use Ecto.Repo,
    otp_app: :not_myself_cleaning_elixir,
    adapter: Ecto.Adapters.Postgres
end
