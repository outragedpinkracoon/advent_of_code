defmodule Day4 do
  @moduledoc """
  Top level module for the project.
  """

  alias Day4.MostAsleep
  alias Day4.Parser
  alias Day4.TimeSlotGenerator
  alias Day4.TotalSleep

  def run(filename) do
    filename
    |> Parser.run
    |> TimeSlotGenerator.run
    |> TotalSleep.by_guard
    |> MostAsleep.run
  end
end
