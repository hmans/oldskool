defmodule Oldskool.Plugs.CurrentSite do
  import Plug.Conn

  alias Ecto.Query
  alias Oldskool.Site
  alias Oldskool.Repo

  def init(default), do: default

  def call(conn, _) do
    assign(conn, :current_site, find_current_site)
  end

  defp find_current_site do
    # TODO: actually find current site by host name

    Site
    |> Query.first
    |> Repo.one
  end
end
