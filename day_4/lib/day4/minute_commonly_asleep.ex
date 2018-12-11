defmodule Day4.MinuteCommonlyAsleep do
  @moduledoc """
  Given a list of timeslots for a guard, work out the minute of the hour they are most commonly asleep
  """

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
    |> find_max
  end

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

  defp find_max(items) do
    items
    |> Enum.into(%{}, fn {k, v} -> {v, k} end)
    |> Enum.max
    |> find_minute
  end

  defp find_minute({_, minute}) do
    minute
  end

  defp update_result(result, nil, minute) do
    Map.put(result, minute, 1)
  end

  defp update_result(result, count, minute) do
    Map.put(result, minute, count + 1)
  end
end
