defmodule Day4.MapHelper do
  @moduledoc """
  Helper functions for maps
  """

  @doc """
  Given a map of keys to numeric values, returns the key with the
  highest value

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
end
