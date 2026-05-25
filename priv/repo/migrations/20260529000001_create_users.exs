defmodule NotMyselfCleaning.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :login, :text, null: false
      add :password, :text, null: false
      add :full_name, :text, null: false
      add :phone, :text, null: false
      add :email, :text, null: false
    end

    create unique_index(:users, [:login])
  end
end
