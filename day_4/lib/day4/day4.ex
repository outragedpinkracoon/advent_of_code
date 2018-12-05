defmodule Day4 do
  @moduledoc """
  Top level module for the project
  """
  import Day4.Parser, only: [read_file: 1, parse: 1]
  import Day4.Transformer, only: [transform: 1]
  def run(filename) do
    filename
    |> read_file
    |> parse
    |> Enum.sort_by(&(&1.date))
    |> transform
  end
end
