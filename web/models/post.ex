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
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body, :author_id, :site_id])
    |> render_body_to_html
  end

  defp render_body_to_html(changeset) do
    body = get_change(changeset, :body)

    if body do
      put_change(changeset, :html, Earmark.to_html(body))
    else
      changeset
    end
  end

end
