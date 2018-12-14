# credo:disable-for-lines:1
defmodule MinuteCommonlyAsleepTest do
  use ExUnit.Case
  doctest Day4.MinuteCommonlyAsleep

  alias Day4.DateHelper
  alias Day4.MinuteCommonlyAsleep
  alias Day4.TimeSlot

  test "run with test input" do
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
    assert MinuteCommonlyAsleep.most_common([1, 2, 3, 2, 4, 4]) == 4
    assert MinuteCommonlyAsleep.most_common([1]) == 1
    assert MinuteCommonlyAsleep.most_common([22, 11, 44, 56, 78, 49, 11]) == 11
    assert MinuteCommonlyAsleep.most_common([22, 78, 44, 56, 78, 49, 11, 78]) == 78
    assert MinuteCommonlyAsleep.most_common([22, 33]) == 33
  end
end
