defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  alias Oldskool.Post

  plug :verify_authorized

  def index(conn, _) do
    posts = conn
    |> current_site_posts
    |> order_by(desc: :inserted_at)
    |> Repo.all

    conn
    |> authorize!(Post)
    |> render("index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = conn |> current_site_posts |> Repo.get!(id)

    conn
    |> authorize!(post)
    |> assign(:page_title, post.title)
    |> render("show.html", post: post)
  end

  def new(conn, _) do
    changeset = Post.changeset(%Post{})

    conn
    |> authorize!(Post)
    |> assign(:page_title, "New Post")
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    conn = authorize!(conn, Post)

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
    post = conn |> current_site_posts |> Repo.get!(id)
    changeset = Post.changeset(post)

    conn
    |> authorize!(post)
    |> assign(:page_title, "Editing Post")
    |> render("edit.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = conn |> current_site_posts |> Repo.get!(id)

    conn = authorize!(conn, post)

    case Repo.update(Post.changeset(post, post_params)) do
      {:ok, _} ->
        redirect(conn, to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = conn |> current_site_posts |> Repo.get!(id)

    conn = authorize!(conn, post)

    Repo.delete!(post)
    redirect(conn, to: post_path(conn, :index))
  end

  defp current_site_posts(conn) do
     assoc(conn.assigns.current_site, :posts)
  end
end
