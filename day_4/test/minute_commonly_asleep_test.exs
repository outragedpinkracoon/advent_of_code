# credo:disable-for-lines:1
defmodule MinuteCommonlyAsleepTest do
  use ExUnit.Case
  doctest Day4.MinuteCommonlyAsleep

  alias Day4.DateHelper
  alias Day4.MinuteCommonlyAsleep
  alias Day4.TimeSlot

  test "run" do
    slots = [
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
      }
    ]

    assert MinuteCommonlyAsleep.run(slots) == 24
  end

  test "most common" do
    assert MinuteCommonlyAsleep.most_common([1, 2, 3, 2, 4]) == 2
  end
end
