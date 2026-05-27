defmodule NotMyselfCleaning.Requests do
  @moduledoc """
  The Requests context.
  """

  import Ecto.Query, warn: false
  alias NotMyselfCleaning.Repo
  alias NotMyselfCleaning.Requests.CleaningRequest

  def list_all_requests do
    CleaningRequest
    |> order_by([r], desc: r.created_at)
    |> Repo.all()
  end

  def list_user_requests(user_id) do
    CleaningRequest
    |> where([r], r.user_id == ^user_id)
    |> order_by([r], desc: r.created_at)
    |> Repo.all()
  end

  def get_request!(id), do: Repo.get!(CleaningRequest, id)

  def create_request(attrs, user) do
    %CleaningRequest{}
    |> CleaningRequest.create_changeset(attrs, user)
    |> Repo.insert()
  end

  def update_request_status(id, status, comment) do
    request = get_request!(id)

    request
    |> CleaningRequest.update_status_changeset(%{status: status, status_comment: comment})
    |> Repo.update()
  end
end
