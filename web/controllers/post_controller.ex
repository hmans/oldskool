defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  alias Ecto.Query

  plug :load_current_user

  def index(conn, _) do
    render(conn, "index.html")
  end

  defp load_current_user(conn, _) do
    user = Oldskool.User |> Query.first |> Repo.one
    conn |> assign(:current_user, user)
  end
end
