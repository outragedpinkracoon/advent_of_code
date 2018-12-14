# credo:disable-for-lines:1
defmodule TimeSoltGeneratorTest do
  use ExUnit.Case
  doctest Day4.TimeSlotGenerator

  alias Day4.DateHelper
  alias Day4.InputLine
  alias Day4.TimeSlot
  alias Day4.TimeSlotGenerator

  test "transform with good data" do
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
        guard: 10,
        mins_asleep: 20
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 30),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 55),
        guard: 10,
        mins_asleep: 25
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 03, 00, 24),
        end: DateHelper.create_date_time(1518, 11, 03, 00, 29),
        guard: 10,
        mins_asleep: 5
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 02, 00, 40),
        end: DateHelper.create_date_time(1518, 11, 02, 00, 50),
        guard: 99,
        mins_asleep: 10
      },
    ]

    assert TimeSlotGenerator.run(input) == expected
  end

  test "transform with bad data" do
    input = [
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #100 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 23, 57), action: "Guard #109 begins shift"},
      %InputLine{date: DateHelper.create_date_time(1518, 11, 01, 23, 58), action: "wakes up"},
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
        guard: 10,
        mins_asleep: 20
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 30),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 55),
        guard: 10,
        mins_asleep: 25
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 03, 00, 24),
        end: DateHelper.create_date_time(1518, 11, 03, 00, 29),
        guard: 10,
        mins_asleep: 5
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 02, 00, 40),
        end: DateHelper.create_date_time(1518, 11, 02, 00, 50),
        guard: 99,
        mins_asleep: 10
      },
    ]

    assert TimeSlotGenerator.run(input) == expected
  end

  test "slots for" do
    input = [
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 05),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 25),
        guard: 10,
        mins_asleep: 20
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 30),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 55),
        guard: 10,
        mins_asleep: 25
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 03, 00, 24),
        end: DateHelper.create_date_time(1518, 11, 03, 00, 29),
        guard: 10,
        mins_asleep: 5
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 02, 00, 40),
        end: DateHelper.create_date_time(1518, 11, 02, 00, 50),
        guard: 99,
        mins_asleep: 10
      },
    ]

    expected = [
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 05),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 25),
        guard: 10,
        mins_asleep: 20
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 01, 00, 30),
        end: DateHelper.create_date_time(1518, 11, 01, 00, 55),
        guard: 10,
        mins_asleep: 25
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 03, 00, 24),
        end: DateHelper.create_date_time(1518, 11, 03, 00, 29),
        guard: 10,
        mins_asleep: 5
      },
    ]

    assert TimeSlotGenerator.slots_for(10, input) == expected
  end

  test "find_guard_number" do
    assert TimeSlotGenerator.find_guard_number("Guard #99 begins shift") == 99
    assert TimeSlotGenerator.find_guard_number("Guard #9 begins shift") == 9
    assert TimeSlotGenerator.find_guard_number("Guard #1234 begins shift") == 1234
  end
end
