defmodule NotMyselfCleaningWeb.RequestController do
  use NotMyselfCleaningWeb, :controller

  alias NotMyselfCleaning.Requests

  plug(:require_auth)

  def index(conn, _params) do
    current_user = conn.assigns.current_user

    requests =
      if current_user.is_admin do
        Requests.list_all_requests()
      else
        Requests.list_user_requests(current_user.user_id)
      end

    render(conn, :index, requests: requests, current_user: current_user)
  end

  def new(conn, _params) do
    current_user = conn.assigns.current_user

    render(conn, :new,
      current_user: current_user,
      values: %{"contact" => "#{current_user.phone}, #{current_user.email}"},
      error: ""
    )
  end

  def create(conn, params) do
    current_user = conn.assigns.current_user

    case Requests.create_request(params, %{
           id: current_user.user_id,
           full_name: current_user.full_name,
           phone: current_user.phone,
           email: current_user.email
         }) do
      {:ok, _request} ->
        redirect(conn, to: "/requests")

      {:error, %Ecto.Changeset{} = changeset} ->
        error = format_changeset_errors(changeset)

        conn
        |> put_status(422)
        |> render(:new, current_user: current_user, values: params, error: error)
    end
  end

  defp require_auth(conn, _opts) do
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> redirect(to: "/login")
        |> halt()

      _user ->
        conn
    end
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
end
