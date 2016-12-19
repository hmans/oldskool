defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  def index(conn, _) do
    posts = conn.assigns.current_site |> assoc(:posts) |> Repo.all
    render(conn, "index.html", posts: posts)
  end
end
