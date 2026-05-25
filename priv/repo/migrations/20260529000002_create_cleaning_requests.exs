defmodule NotMyselfCleaning.Repo.Migrations.CreateCleaningRequests do
  use Ecto.Migration

  def change do
    create table(:cleaning_requests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      add :full_name, :text, null: false
      add :phone, :text, null: false
      add :email, :text, null: false
      add :address, :text, null: false
      add :contact, :text, null: false
      add :service, :text, null: false
      add :date_time, :text, null: false
      add :payment, :text, null: false
      add :status, :text, null: false
      add :cancel_reason, :text, null: false, default: ""
      add :status_comment, :text, null: false, default: ""
      add :created_at, :utc_datetime, null: false, default: fragment("now()")
    end

    create constraint(:cleaning_requests, :status_check,
             check: "status IN ('new', 'in_work', 'done', 'cancelled')")

    create index(:cleaning_requests, [:user_id])
    create index(:cleaning_requests, [:created_at])
  end
end
