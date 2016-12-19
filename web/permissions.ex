defimpl Canada.Can, for: Oldskool.User do
  alias Oldskool.Post
  alias Oldskool.User

  # Anyone can read all posts
  def can?(%User{}, :read, %Post{}), do: true

  # Post authors can update posts
  def can?(%User{id: id}, action, %Post{author_id: id})
    when action in [:update, :destroy], do: true

  # Default everything else to false
  def can?(_, _, _), do: false
end
