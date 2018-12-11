defmodule Day4 do
  @moduledoc """
  Top level module for the project.
  """

  alias Day4.Analyzer
  alias Day4.Parser
  alias Day4.TimeSlotGenerator

  def run(filename) do
    filename
    |> Parser.run
    |> TimeSlotGenerator.run
    |> Analyzer.total_sleep_per_guard
  end
end
