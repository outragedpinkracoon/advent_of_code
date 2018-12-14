defmodule Day4.MinuteCommonlyAsleep do
  @moduledoc """
  Given a list of timeslots for a guard, work out the minute of the hour they are most commonly asleep
  """

  alias Day4.MapHelper

  @doc """
  Given a list of timeslots return the minute the guard was most commonly asleep.

  """
  def run(slots) do
    slots
    |> Enum.map(fn(s) -> %{start: s.start.minute, end: s.end.minute} end)
    |> convert_to_ranges
    |> List.flatten
    |> most_common
  end

  @doc """
  Given an list of start and end minutes in maps, returns a list of the
  range of minutes that they spent asleep i.e. not including the end
  minute when they woke up.

  ##Example
    iex> input = [%{start: 1, end: 5}, %{start: 4, end: 10}]
    iex> Day4.MinuteCommonlyAsleep.convert_to_ranges(input)
    [[1, 2, 3, 4], [4, 5, 6, 7, 8, 9]]
  """
  def convert_to_ranges(items) do
    items |> Enum.map(fn(s) ->
      finish = s.end - 1
      Enum.to_list(s.start..finish)
    end)
  end

  @doc """
  Given a list of minutes, count the occurence of each one and return
  the most commonly seen one
  """
  def most_common([minute | t]) do
    %{minute => 1}
    |> most_common(t)
    |> MapHelper.max_value
  end

  def most_common(result, [minute | t]) do
    {_, updated} = Map.get_and_update(result, minute, fn current_value ->
      value = case current_value do
        nil -> 1
        _ -> current_value + 1
      end
      {current_value, value}
    end)

    updated
    |> most_common(t)
  end

  def most_common(result, []), do: result
end
