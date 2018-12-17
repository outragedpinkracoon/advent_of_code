defmodule Day4.SleepMinutes do
  @moduledoc """
  Given a list of timeslots for a guard, work out the minute of the hour they are most commonly asleep
  """

  alias Day4.EnumHelper

  @doc """
  Given a list of timeslots return the minute the guard was most commonly asleep.

  """
  def asleep_the_most_on(slots) do
    slots
    |> Enum.map(fn(s) -> %{start: s.start.minute, end: s.end.minute} end)
    |> ranges_in
    |> List.flatten
    |> EnumHelper.most_occuring_item
  end

  @doc """
  Given an list of start and end minutes in maps, returns a list of the
  range of minutes that they spent asleep i.e. not including the end
  minute when they woke up.

  ##Example
    iex> input = [%{start: 1, end: 5}, %{start: 4, end: 10}]
    iex> Day4.SleepMinutes.ranges_in(input)
    [[1, 2, 3, 4], [4, 5, 6, 7, 8, 9]]
  """
  def ranges_in(items) do
    items |> Enum.map(fn(s) ->
      finish = s.end - 1
      Enum.to_list(s.start..finish)
    end)
  end
end
