defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  def index(conn, _) do
    posts = Repo.all(Oldskool.Post)
    render(conn, "index.html", posts: posts)
  end
end
