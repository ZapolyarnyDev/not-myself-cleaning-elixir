defmodule NotMyselfCleaningWeb.AdminController do
  use NotMyselfCleaningWeb, :controller

  alias NotMyselfCleaning.Requests

  plug(:require_admin)

  def index(conn, _params) do
    requests = Requests.list_all_requests()
    current_user = conn.assigns.current_user

    render(conn, :index, requests: requests, current_user: current_user, error: "")
  end

  def update_status(conn, %{"request_id" => id, "status" => status, "comment" => comment}) do
    current_user = conn.assigns.current_user

    case Requests.update_request_status(id, status, comment) do
      {:ok, _request} ->
        redirect(conn, to: "/admin")

      {:error, %Ecto.Changeset{} = changeset} ->
        error = format_changeset_errors(changeset)
        requests = Requests.list_all_requests()

        conn
        |> put_status(422)
        |> render(:index, requests: requests, current_user: current_user, error: error)
    end
  end

  defp require_admin(conn, _opts) do
    case conn.assigns[:current_user] do
      %{is_admin: true} ->
        conn

      _ ->
        conn
        |> redirect(to: "/requests")
        |> halt()
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
