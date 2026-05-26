defmodule NotMyselfCleaningWeb.AuthController do
  use NotMyselfCleaningWeb, :controller

  alias NotMyselfCleaning.Accounts

  def home(conn, _params) do
    case get_session(conn, :session_token) do
      nil -> redirect(conn, to: "/login")
      _token -> redirect(conn, to: "/requests")
    end
  end

  def register_page(conn, _params) do
    render(conn, :register, error: "", values: %{})
  end

  def register(conn, params) do
    case Accounts.register_user(params) do
      {:ok, user} ->
        session_data = Accounts.session_from_user(user)
        {:ok, _session} = Accounts.create_session(session_data)

        conn
        |> put_session(:session_token, session_data.token)
        |> redirect(to: "/requests")

      {:error, %Ecto.Changeset{} = changeset} ->
        error = format_changeset_errors(changeset)
        render(conn, :register, error: error, values: params)
    end
  end

  def login_page(conn, _params) do
    render(conn, :login, error: "", values: %{})
  end

  def login(conn, %{"login" => login, "password" => password}) do
    if login == admin_login() && password == admin_password() do
      session_data = Accounts.admin_session()
      {:ok, _session} = Accounts.create_session(session_data)

      conn
      |> put_session(:session_token, session_data.token)
      |> redirect(to: "/admin")
    else
      case Accounts.authenticate_user(login, password) do
        {:ok, user} ->
          session_data = Accounts.session_from_user(user)
          {:ok, _session} = Accounts.create_session(session_data)

          conn
          |> put_session(:session_token, session_data.token)
          |> redirect(to: "/requests")

        {:error, :invalid_credentials} ->
          conn
          |> put_status(401)
          |> render(:login, error: "Неверный логин или пароль.", values: %{"login" => login})
      end
    end
  end

  def health(conn, _params) do
    json(conn, %{status: "ok"})
  end

  def logout(conn, _params) do
    case get_session(conn, :session_token) do
      nil -> :ok
      token -> Accounts.delete_session(token)
    end

    conn
    |> delete_session(:session_token)
    |> redirect(to: "/login")
  end

  defp format_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.map(fn {field, errors} -> "#{field}: #{Enum.join(errors, ", ")}" end)
    |> Enum.join("; ")
  end

  defp admin_login do
    System.get_env("ADMIN_LOGIN", "adminka")
  end

  defp admin_password do
    System.get_env("ADMIN_PASSWORD", "password")
  end
end
