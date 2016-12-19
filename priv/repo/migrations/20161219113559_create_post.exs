defmodule Oldskool.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :site_id, references(:sites, on_delete: :delete_all)
      add :author_id, references(:users, on_delete: :nilify_all)
      add :title, :string
      add :body, :text, null: false
      add :html, :text

      timestamps()
    end

    create index(:posts, [:author_id])
    create index(:posts, [:site_id])
  end
end
