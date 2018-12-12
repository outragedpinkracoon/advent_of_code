defmodule Day4.MapHelper do
  @moduledoc """
  Helper functions for maps
  """

  @doc """
  Returns the id of the guard that has slept the most and the time they spent asleep

  ## Example
  iex> Day4.MapHelper.max_value(%{10 => 50, 99 => 30, 101 => 5})
  10
  """
  def max_value(items) do
    items
    |> Enum.into(%{}, fn {k, v} -> {v, k} end)
    |> Enum.max
    |> find_value
  end

  defp find_value({_, value}) do
    value
  end
end
