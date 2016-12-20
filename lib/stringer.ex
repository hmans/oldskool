defmodule Stringer do
  @doc """
  Converts a string into a new string that you can use as part of a URL. More
  specifically, this involves lowercasing the string, removing most
  non-alphanumeric characters, and replacing whitespace with dashes.

  Example:

      iex> Stringer.parameterize("Hello, world!")
      "hello-world"
  """
  def parameterize(string) do
    string
    |> String.downcase
    |> String.replace(~r/[^ a-zA-Z0-9]/, "")
    |> String.replace(~r/\s/, "-")
    |> String.replace(~r/-{2,}/, "-")
  end
end
