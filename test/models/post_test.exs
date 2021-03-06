defmodule Oldskool.PostTest do
  use Oldskool.ModelCase

  alias Oldskool.Post

  @valid_attrs %{body: "some content", title: "some content"}
  @invalid_attrs %{}

  defp a_post do
    %Post{author_id: 1, site_id: 1}
  end

  test "changeset with valid attributes" do
    changeset = Post.changeset(a_post, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(a_post, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset will render body to html" do
    params = %{ @valid_attrs | body: "I'm _Markdown_ formatted!" }
    changeset = Post.changeset(a_post, params)
    assert changeset.changes.html == "<p>I’m <em>Markdown</em> formatted!</p>\n"
  end
end
