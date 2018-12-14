defmodule Day4.DateHelper do
  @moduledoc """
  Some helper functions for working with Dates.
  """

  @doc """
  Given a year, month, day, hour and minute returns an Elixir DateTime.

  ## Example
    iex> Day4.DateHelper.create_date_time(1518, 11, 04, 00, 46)
    %DateTime{year: 1518, month: 11, day: 04, zone_abbr: "AMT",
              hour: 00, minute: 46, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  """
  def create_date_time(y, mo, d, h, mi) do
    %DateTime{year: y, month: mo, day: d, zone_abbr: "AMT",
              hour: h, minute: mi, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  end

  @doc """
  Given a start and end date, returns the difference in minutes between the two

  ## Examples
    alias Day4.DateHelper, as: dh
    start1 = dh.create_date_time(1518, 11, 04, 6, 15)
    end1 = dh.create_date_time(1518, 11, 04, 6, 55)

    start2 = dh.create_date_time(1518, 11, 04, 6, 55)
    end2 = dh.create_date_time(1518, 11, 04, 7, 05)

    start3 = dh.create_date_time(1518, 11, 04, 23, 30)
    end3 = dh.create_date_time(1518, 11, 05, 00, 35)

    assert Day4.TimeSlotGenerator.sleep_time(start1, end1) == 40
    assert Day4.TimeSlotGenerator.sleep_time(start2, end2) == 10
    assert Day4.TimeSlotGenerator.sleep_time(start3, end3) == 65
  """
  def minutes_between(start, finish) do
    (DateTime.diff(finish, start) / 60) - 1
  end
end
