# credo:disable-for-lines:1
defmodule AnalyzerTest do
  use ExUnit.Case
  doctest Day4.TimeSlotGenerator

  alias Day4.Analyzer
  alias Day4.DateHelper
  alias Day4.TimeSlot

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

    assert Analyzer.total_sleep_per_guard(input) == expected
  end
end
