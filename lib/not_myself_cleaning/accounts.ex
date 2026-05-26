defmodule NotMyselfCleaning.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias NotMyselfCleaning.Repo
  alias NotMyselfCleaning.Accounts.Password
  alias NotMyselfCleaning.Accounts.{User, Session}

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_login(login) do
    Repo.get_by(User, login: login)
  end

  def authenticate_user(login, password) do
    user = get_user_by_login(login)

    cond do
      user && Password.verify(password, user.password) ->
        {:ok, user}

      user ->
        {:error, :invalid_credentials}

      true ->
        Password.no_user_verify()
        {:error, :invalid_credentials}
    end
  end

  def create_session(attrs) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  def get_session(token) do
    Repo.get(Session, token)
  end

  def delete_session(token) do
    case get_session(token) do
      nil -> {:ok, nil}
      session -> Repo.delete(session)
    end
  end

  def session_from_user(user) do
    %{
      token: Session.generate_token(),
      user_id: user.id,
      login: user.login,
      full_name: user.full_name,
      phone: user.phone,
      email: user.email,
      is_admin: false
    }
  end

  def admin_session do
    %{
      token: Session.generate_token(),
      user_id: "admin",
      login: System.get_env("ADMIN_LOGIN", "adminka"),
      full_name: System.get_env("ADMIN_FULL_NAME", "Администратор"),
      phone: "",
      email: "",
      is_admin: true
    }
  end
end
