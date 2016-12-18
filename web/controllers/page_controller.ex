defmodule Oldskool.PageController do
  use Oldskool.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
