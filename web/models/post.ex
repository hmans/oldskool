defmodule Oldskool.Post do
  use Oldskool.Web, :model

  schema "posts" do
    belongs_to :site, Oldskool.Site
    belongs_to :author, Oldskool.User

    field :title, :string
    field :body, :string
    field :html, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :html])
    |> validate_required([:title, :body, :html])
  end
end
