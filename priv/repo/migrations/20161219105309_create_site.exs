defmodule Oldskool.Repo.Migrations.CreateSite do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :owner_id, references(:users, on_delete: :delete_all)
      add :title, :string
      add :host, :string
      add :description, :text

      timestamps()
    end

    create index(:sites, [:owner_id])
    create unique_index(:sites, [:host])
  end
end
