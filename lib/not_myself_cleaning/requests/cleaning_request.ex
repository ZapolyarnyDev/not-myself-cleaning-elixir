defmodule NotMyselfCleaning.Requests.CleaningRequest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @statuses ~w(new in_work done cancelled)

  schema "cleaning_requests" do
    field(:full_name, :string)
    field(:phone, :string)
    field(:email, :string)
    field(:address, :string)
    field(:contact, :string)
    field(:service, :string)
    field(:date_time, :string)
    field(:payment, :string)
    field(:status, :string, default: "new")
    field(:cancel_reason, :string, default: "")
    field(:status_comment, :string, default: "")
    field(:created_at, :utc_datetime)

    belongs_to(:user, NotMyselfCleaning.Accounts.User)
  end

  def create_changeset(request, attrs, user) do
    request
    |> cast(attrs, [:address, :contact, :service, :date_time, :payment])
    |> validate_required([:address, :contact, :service, :date_time, :payment])
    |> put_change(:user_id, user.id)
    |> put_change(:full_name, user.full_name)
    |> put_change(:phone, user.phone)
    |> put_change(:email, user.email)
    |> put_change(:status, "new")
    |> put_change(:created_at, DateTime.utc_now())
  end

  def update_status_changeset(request, attrs) do
    request
    |> cast(attrs, [:status, :status_comment])
    |> validate_required([:status, :status_comment])
    |> validate_inclusion(:status, @statuses)
  end
end
