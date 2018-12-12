defmodule Day4.MinuteCommonlyAsleep do
  @moduledoc """
  Given a list of timeslots for a guard, work out the minute of the hour they are most commonly asleep
  """

  alias Day4.MapHelper

  @doc """
  Given a list of timeslots return the minute the guard was most commonly asleep
  """
  def run(slots) do
    slots
    |> Enum.map(fn(s) -> %{start: s.start.minute, end: s.end.minute} end)
    |> Enum.map(fn(s) -> Enum.to_list(s.start..s.end) end)
    |> List.flatten
    |> most_common
  end

  def most_common([minute | t]) do
    %{minute => 1}
    |> most_common(t)
    |> MapHelper.max_value
  end

  # TODO: This is super similar to the TotalSleep.by_guard function, we should pull it out for reuse
  def most_common(result, [minute | t]) do
    count = case Map.fetch(result, minute) do
      {:ok, value} -> value
      :error -> nil
    end

    result
    |> update_result(count, minute)
    |> most_common(t)
  end

  def most_common(result, []), do: result

  defp update_result(result, nil, minute) do
    Map.put(result, minute, 1)
  end

  defp update_result(result, count, minute) do
    Map.put(result, minute, count + 1)
  end
end
