defmodule Oldskool.UserAuth do
  alias Oldskool.User
  alias Oldskool.Repo
  import Ecto.Query

  def from_auth(auth) do
    user = find_or_create(auth)

    case user do
      %User{} ->
        {:ok, user}
      _ ->
        {:error, "User could not be loaded"}
    end
  end

  defp find_or_create(auth) do
    email = auth.info.email

    query = from u in User,
      where: u.email == ^email

    Repo.one(query)
  end
end
