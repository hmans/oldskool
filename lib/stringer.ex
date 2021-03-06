defmodule Stringer do
  @moduledoc """
  Various String conversion functions I may or may not eventually extract
  into their own Hex package. Wheee!
  """


  @doc """
  Converts a string into a new string that you can use as part of a URL. More
  specifically, this involves lowercasing the string, removing most
  non-alphanumeric characters, and replacing whitespace with dashes.

  Example:

      iex> Stringer.parameterize("Hello, world!")
      "hello-world"

  Stringer will also correctly convert umlauts:

      iex> Stringer.parameterize("I'm über!")
      "im-ueber"

  """
  def parameterize(string) do
    string
    |> String.downcase
    |> String.replace(~r/ä/, "ae")
    |> String.replace(~r/ö/, "oe")
    |> String.replace(~r/ü/, "ue")
    |> String.replace(~r/ß/, "ss")
    |> String.replace(~r/[^ a-zA-Z0-9]/, "")
    |> String.replace(~r/\s/, "-")
    |> String.replace(~r/-{2,}/, "-")
  end


  @doc """
  Converts a string to a "titleized" format, with all words (with some exceptions)
  individually capitalized.

  Examples:

      iex> Stringer.titleize("I'm the king of the world!")
      "I'm The King Of The World!"

  """
  def titleize(string) do
    string
    |> String.split
    |> Enum.map_join(" ", &String.capitalize(&1))
  end
end
