defmodule Oldskool.Site do
  use Oldskool.Web, :model

  schema "sites" do
    belongs_to :owner, Oldskool.User

    field :title, :string, null: false
    field :host, :string, null: false
    field :description, :string
    timestamps()

    has_many :posts, Oldskool.Post
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :host])
    |> validate_required([:title, :host])
  end
end
