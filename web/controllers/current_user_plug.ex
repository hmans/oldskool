defmodule Oldskool.Plugs.CurrentUser do
  import Plug.Conn

  alias Oldskool.User
  alias Oldskool.Repo

  def init(default), do: default

  def call(conn, _) do
    assign(conn, :current_user, find_current_user(conn))
  end

  defp find_current_user(conn) do
    load_current_user_from_cookie(conn) || User.logged_out
  end

  defp load_current_user_from_cookie(conn) do
    if current_user_id = get_session(conn, :current_user_id) do
      Repo.get!(User, current_user_id)
    end
  end
end
