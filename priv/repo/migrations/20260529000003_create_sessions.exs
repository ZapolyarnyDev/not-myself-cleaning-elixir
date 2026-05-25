defmodule NotMyselfCleaning.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :token, :text, primary_key: true
      add :user_id, :text, null: false
      add :login, :text, null: false
      add :full_name, :text, null: false
      add :phone, :text, null: false
      add :email, :text, null: false
      add :is_admin, :boolean, null: false
      add :created_at, :utc_datetime, null: false, default: fragment("now()")
    end
  end
end
