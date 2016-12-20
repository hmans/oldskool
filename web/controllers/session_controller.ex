defmodule Oldskool.SessionController do
  use Oldskool.Web, :controller

  plug Ueberauth

  def new(conn, _) do
    render(conn, "new.html")
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user_id)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/session/new")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Oldskool.UserAuth.from_auth(auth) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/session/new")
    end
  end
end
