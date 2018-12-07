# credo:disable-for-lines:1
defmodule TimeSoltGeneratorTest do
  use ExUnit.Case
  doctest Day4.TimeSlotGenerator

  alias Day4.InputLine
  alias Day4.TimeSlotGenerator
  alias Day4.DateHelper
  alias Day4.TimeSlot
  # who spent the most minutes asleep
  # what minute did they sleep the most of the hour
  # get all the minutes from the slots, generate the ranges and count the one that appears the most

  test "transform" do
    input = [
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 23, 58), action: "Guard #99 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 02, 00, 50), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 03, 00, 05), action: "Guard #10 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 03, 00, 24), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 03, 00, 29), action: "wakes up"},
    ]

    expected = [
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 05),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 25),
        guard: 10
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 30),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 55),
        guard: 10
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 03, 00, 24),
        end: DateHelper.create_date_time(1518, 11, 03, 00, 29),
        guard: 10
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 02, 00, 40),
        end: DateHelper.create_date_time(1518, 11, 02, 00, 50),
        guard: 99
      },
    ]

    assert TimeSlotGenerator.run(input) == expected
  end

  test "find_guard_number" do
    assert TimeSlotGenerator.find_guard_number("Guard #99 begins shift") == 99
    assert TimeSlotGenerator.find_guard_number("Guard #9 begins shift") == 9
    assert TimeSlotGenerator.find_guard_number("Guard #1234 begins shift") == 1234
  end
end
