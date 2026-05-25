defmodule NotMyselfCleaning.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias NotMyselfCleaning.Accounts.Password

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field(:login, :string)
    field(:password, :string)
    field(:full_name, :string)
    field(:phone, :string)
    field(:email, :string)

    has_many(:cleaning_requests, NotMyselfCleaning.Requests.CleaningRequest)
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password, :full_name, :phone, :email])
    |> validate_required([:login, :password, :full_name, :phone, :email])
    |> validate_length(:login, min: 3, max: 30)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:login)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password, Password.hash(password))
    end
  end
end
