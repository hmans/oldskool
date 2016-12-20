defmodule Oldskool.Permissions do
  alias Oldskool.Post
  alias Oldskool.User

  def can?(%User{id: user_id}, action, %Post{author_id: user_id})
    when action in [:update, :delete], do: true

  def can?(%User{}, :create, Post), do: true

  def can?(_, action, subject) do
    case {action, subject} do
      {:read, %Post{}} -> true
      {_, _} -> false
    end
  end
end

defimpl Canada.Can, for: Atom do
  def can?(nil, verb, subject),
    do: Oldskool.Permissions.can?(nil, verb, subject)
end

defimpl Canada.Can, for: Oldskool.User do
  def can?(user, verb, subject),
    do: Oldskool.Permissions.can?(user, verb, subject)
end
