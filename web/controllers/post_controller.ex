defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  alias Oldskool.Post

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

  def new(conn, _) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post = %Post{
      site_id: conn.assigns.current_site.id,
      author_id: conn.assigns.current_user.id
    }

    changeset = Post.changeset(post, post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        redirect conn, to: post_path(conn, :show, post)
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    # TODO: check if current_user is allowed to edit the post!
    post = conn |> current_site_posts |> Repo.get(id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = conn |> current_site_posts |> Repo.get(id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        redirect(conn, to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp current_site_posts(conn) do
     assoc(conn.assigns.current_site, :posts)
  end
end
