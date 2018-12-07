defmodule Day4.DateHelper do
  @moduledoc """
  Some helper functions for working with Dates
  """

  @doc """
  Given a year, month, day, hour and minute returns an Elixir DateTime

  ## Example
    iex> Day4.Parser.create_date_time(1518, 11, 04, 00, 46)
    %DateTime{year: 1518, month: 11, day: 04, zone_abbr: "AMT",
              hour: 00, minute: 46, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  """
  def create_date_time(y, mo, d, h, mi) do
    %DateTime{year: y, month: mo, day: d, zone_abbr: "AMT",
              hour: h, minute: mi, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  end
end
