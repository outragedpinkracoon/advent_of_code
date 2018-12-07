defmodule Day4.Analyzer do
  @moduledoc """
  Analyzes the input from TimeSlot information and works out some interesting facts
  """

  @doc """
  Given a list of TimeSlot structs, returns a map where the keys are the guard number
  and the values are the total time that guard spent asleep
  e.g. %{ 10 => 30, 99 => 15 } would show that guard number 10 spent 30 minutes asleep
  and guard number 99 spent 15 minutes asleep
  """
  def total_sleep_per_guard([h | t]) do
    result = Map.put(%{}, h.guard, sleep_time(h))
    total_sleep_per_guard(result, t)
  end

  def total_sleep_per_guard(result, [h | t]) do
    total = case Map.fetch(result, h.guard) do
      {:ok, value} -> value
      :error -> nil
    end

    result
    |> update_result(total, h)
    |> total_sleep_per_guard(t)
  end

  def total_sleep_per_guard(result, []), do: result

  defp update_result(result, nil, slot) do
    Map.put(result, slot.guard, sleep_time(slot))
  end

  defp update_result(result, total, slot) do
    Map.put(result, slot.guard, sleep_time(slot) + total)
  end

  defp sleep_time(slot) do
    DateTime.diff(slot.end, slot.start) / 60
  end
end
