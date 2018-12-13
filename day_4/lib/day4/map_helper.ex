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
    {_, value} = items
                 |> Enum.into(%{}, fn {k, v} -> {v, k} end)
                 |> Enum.max

    value
  end

  @doc """
  Given a map and key, return the value of that key or nil if
  it is not present in the map

  ## Example
  iex> Day4.MapHelper.value_or_nil(%{cat: "dog"}, :cat)
  "dog"
  iex> Day4.MapHelper.value_or_nil(%{cat: "dog"}, :mouse)
  nil
  """
  def value_or_nil(map, key) do
    case Map.fetch(map, key) do
      {:ok, value} -> value
      :error -> nil
    end
  end
end
