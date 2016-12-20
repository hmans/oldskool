defmodule Oldskool.User do
  use Oldskool.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps
  end

  def logged_out do
    %__MODULE__{}
  end
end
