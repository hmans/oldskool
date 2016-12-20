defmodule StringerTest do
  use ExUnit.Case, async: true

  doctest Stringer

  describe "parameterize" do
    test "it parameterizes strings" do
      string = "this should be parameterized"
      assert Stringer.parameterize(string) == "this-should-be-parameterized"
    end

    test "it removes non-alphanumeric characters" do
      string = "hello, world"
      assert Stringer.parameterize(string) == "hello-world"
    end

    test "it combines double dashes into one" do
      string = "hello  world"
      assert Stringer.parameterize(string) == "hello-world"
    end
  end
end
