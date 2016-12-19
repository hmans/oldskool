defmodule Oldskool.Plugs.CurrentUser do
  import Plug.Conn

  alias Ecto.Query
  alias Oldskool.User
  alias Oldskool.Repo

  def init(default), do: default

  def call(conn, _) do
    assign(conn, :current_user, find_current_user)
  end

  defp find_current_user do
    # TODO: actually find current user by cookie

    User
    |> Query.first
    |> Repo.one
  end
end
