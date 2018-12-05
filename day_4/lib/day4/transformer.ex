defmodule Day4.Transformer do
  @moduledoc """
  Given a list of Info structs, get data about the guards from it
  """

  @doc """
  Given a list of Info structs, returns them ordered by date
  """
  def order_by_date(items) do
    Enum.sort_by(items, &(&1.date))
  end

  def transform([h|t]) do

  end

  def find_guard_number(input) do
    case Regex.run(~r/#+[0-9][^\s]*/, input) do
      [match] -> parse_number(match)
      nil -> nil
    end
  end

  defp parse_number(input) do
    input
    |> String.replace("#", "")
    |> String.to_integer()
  end
end
