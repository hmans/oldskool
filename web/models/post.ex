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
    |> validate_required([:body, :author_id, :site_id])
    |> render_body_to_html
  end

  defp render_body_to_html(changeset) do
    body = get_change(changeset, :body)

    if body do
      put_change(changeset, :html, Earmark.to_html(body, %Earmark.Options{code_class_prefix: "lang- language-"}))
    else
      changeset
    end
  end
end

defmodule Oldskool.Post.Policy do
  alias Oldskool.User
  alias Oldskool.Post

  def can?(%User{id: user_id}, _action, %Post{author_id: author_id})
    when user_id == author_id, do: true

  def can?(_, :index, _), do: true
  def can?(_, :show, _), do: true
  def can?(%User{}, :new, Post), do: true
  def can?(%User{}, :create, Post), do: true

  def can?(_, _, _), do: false
end


defimpl Phoenix.Param, for: Oldskool.Post do
  def to_param(%{id: id, title: nil}) do
    "#{id}"
  end

  def to_param(%{id: id, title: title}) do
    "#{id}-#{Stringer.parameterize title}"
  end
end
