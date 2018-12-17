defmodule Day4.EnumHelper do
  @moduledoc """
  Helper functions for enums
  """

  alias Day4.MapHelper

  @doc """
  Given a list of items, count the occurence of each one and return
  the most commonly seen one.
  NOTE: Only works for simple number types at the moment
  """
  def most_occuring_item([item | t]) do
    %{item => 1}
    |> most_occuring_item(t)
    |> MapHelper.max_value
  end

  def most_occuring_item(result, [item | t]) do
    {_, updated} = Map.get_and_update(result, item, fn current_value ->
      value = case current_value do
        nil -> 1
        _ -> current_value + 1
      end
      {current_value, value}
    end)

    updated
    |> most_occuring_item(t)
  end

  def most_occuring_item(result, []), do: result
end
