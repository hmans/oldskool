defmodule Oldskool.User do
  use Oldskool.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps
  end
end
