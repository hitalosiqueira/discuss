defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :provider, :string, null: false
      add :token, :string, null: false

      timestamps()
    end
  end
end
