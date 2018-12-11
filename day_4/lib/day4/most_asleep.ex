defmodule Day4.MostAsleep do
  @moduledoc """
  Given a map of guard id to minutes asleep, finds the guard that has slept the most
  """

  @doc """
  Returns the id of the guard that has slept the most and the time they spent asleep

  ## Example
  iex> Day4.MostAsleep.run(%{10 => 50, 99 => 30, 101 => 5})
  10
  """
  def run(input) do
    input
    |>Enum.into(%{}, fn {k, v} -> {v, k} end)
    |>Enum.max
    |>guard_number
  end

  defp guard_number({_, guard_number}) do
    guard_number
  end
end
