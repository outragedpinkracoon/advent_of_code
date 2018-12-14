# credo:disable-for-lines:1
defmodule TotalSleepTest do
  use ExUnit.Case
  doctest Day4.TimeSlotGenerator

  alias Day4.DateHelper
  alias Day4.TimeSlot
  alias Day4.TotalSleep

  test "minutes asleep per guard" do
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
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 04, 00, 36),
        end: DateHelper.create_date_time(1518, 11, 04, 00, 46),
        guard: 99,
        mins_asleep: 10
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 05, 00, 45),
        end: DateHelper.create_date_time(1518, 11, 05, 00, 55),
        guard: 99,
        mins_asleep: 10
      },
    ]

    expected = %{10 => 50, 99 => 30}

    assert TotalSleep.by_guard(input) == expected
  end
end
