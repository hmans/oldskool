defimpl Canada.Can, for: Oldskool.User do
  alias Oldskool.Post
  alias Oldskool.User

  # Anyone can read all posts
  def can?(_, :read, %Post{}), do: true

  # Users can create new posts
  def can?(%User{}, :create, Post), do: true

  # Post authors can update their own posts
  def can?(%User{id: id}, action, %Post{author_id: id})
    when action in [:update, :destroy], do: true

  # Default everything else to false
  def can?(_, _, _), do: false
end
