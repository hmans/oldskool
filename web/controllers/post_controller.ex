defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  # alias Oldskool.Post

  def index(conn, _) do
    posts = conn
    |> current_site_posts
    |> order_by(desc: :inserted_at)
    |> Repo.all

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = conn |> current_site_posts |> Repo.get(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    # TODO: check if current_user is allowed to edit the post!
    post = conn |> current_site_posts |> Repo.get(id)
    render(conn, "edit.html", post: post)
  end

  defp current_site_posts(conn) do
     assoc(conn.assigns.current_site, :posts)
  end
end
