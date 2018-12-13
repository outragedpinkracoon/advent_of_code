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
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 04, 00, 36),
        end: DateHelper.create_date_time(1518, 11, 04, 00, 46),
        guard: 99
      },
      %TimeSlot{
        start: DateHelper.create_date_time(1518, 11, 05, 00, 45),
        end: DateHelper.create_date_time(1518, 11, 05, 00, 55),
        guard: 99
      },
    ]

    expected = %{10 => 50, 99 => 30}

    assert TotalSleep.by_guard(input) == expected
  end

  test "sleep time" do
    slot1 = %TimeSlot{
      start: DateHelper.create_date_time(1518, 11, 04, 6, 15),
      end: DateHelper.create_date_time(1518, 11, 04, 6, 55),
      guard: 99
    }

    slot2 = %TimeSlot{
      start: DateHelper.create_date_time(1518, 11, 04, 6, 55),
      end: DateHelper.create_date_time(1518, 11, 04, 7, 05),
      guard: 99
    }

    slot3 = %TimeSlot{
      start: DateHelper.create_date_time(1518, 11, 04, 23, 30),
      end: DateHelper.create_date_time(1518, 11, 05, 00, 35),
      guard: 99
    }

    assert TotalSleep.sleep_time(slot1) == 40
    assert TotalSleep.sleep_time(slot2) == 10
    assert TotalSleep.sleep_time(slot3) == 65
  end
end
