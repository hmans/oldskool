defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  alias Oldskool.Post

  def index(conn, _) do
    posts = current_site_posts(conn)
    |> order_by(desc: :inserted_at)
    |> Repo.all

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = current_site_posts(conn) |> Repo.get(id)
    render(conn, "show.html", post: post)
  end

  defp current_site_posts(conn) do
     assoc(conn.assigns.current_site, :posts)
  end
end
