defmodule NotMyselfCleaning.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:token, :string, autogenerate: false}

  schema "sessions" do
    field(:user_id, :string)
    field(:login, :string)
    field(:full_name, :string)
    field(:phone, :string)
    field(:email, :string)
    field(:is_admin, :boolean)
    field(:created_at, :utc_datetime)
  end

  def changeset(session, attrs) do
    session
    |> cast(attrs, [:token, :user_id, :login, :full_name, :phone, :email, :is_admin])
    |> validate_required([:token, :user_id, :login, :full_name, :phone, :email, :is_admin])
    |> put_change(:created_at, DateTime.utc_now())
  end

  def generate_token do
    :crypto.strong_rand_bytes(32) |> Base.encode64()
  end
end
