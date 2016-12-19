defmodule Oldskool.UserTest do
  use Oldskool.ModelCase

  alias Oldskool.User

  test "a silly test" do
    user = %User{name: "John Doe", email: "john@doe.com"}
    assert user.email == "john@doe.com"
  end
end
