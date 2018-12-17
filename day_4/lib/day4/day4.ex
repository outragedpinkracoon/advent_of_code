defmodule Day4 do
  @moduledoc """
  Top level module for the project.
  """

  alias Day4.MapHelper
  alias Day4.Parser
  alias Day4.SleepMinutes
  alias Day4.TimeSlotGenerator
  alias Day4.TotalSleep

  def part1(filename) do
    all_slots = filename
                |> Parser.run
                |> TimeSlotGenerator.run

    sleepiest_guard = all_slots
                      |> TotalSleep.by_guard
                      |> MapHelper.max_value

    common_minute = sleepiest_guard
                    |> TimeSlotGenerator.slots_for(all_slots)
                    |> SleepMinutes.asleep_the_most_on

    if Mix.env != :test do
      IO.puts "Guard: #{sleepiest_guard}, mins: #{common_minute}"
    end

    common_minute * sleepiest_guard
  end
end
