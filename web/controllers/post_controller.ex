defmodule Oldskool.PostController do
  use Oldskool.Web, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end
end
