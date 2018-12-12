defmodule Day4 do
  @moduledoc """
  Top level module for the project.
  """

  alias Day4.MapHelper
  alias Day4.MinuteCommonlyAsleep
  alias Day4.Parser
  alias Day4.TimeSlotGenerator
  alias Day4.TotalSleep

  def run(filename) do
    all_slots =
    filename
    |> Parser.run
    |> TimeSlotGenerator.run

    guard =
    all_slots
    |> TotalSleep.by_guard
    |> MapHelper.max_value

    common_minute =
    guard
    |> TimeSlotGenerator.slots_for(all_slots)
    |> MinuteCommonlyAsleep.run

    if Mix.env != :test do
      IO.puts "Guard: #{guard}, mins: #{common_minute}"
    end

    common_minute * guard
  end
end
