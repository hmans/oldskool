defmodule Oldskool.PostView do
  use Oldskool.Web, :view

  def format_time(datetime) do
    Timex.format!(datetime, "{Mfull} {D}, {YYYY} &middot; {h24}:{m}") |> raw
  end
end
