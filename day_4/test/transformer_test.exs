# credo:disable-for-lines:1
defmodule TransformerTest do
  use ExUnit.Case
  doctest Day4.Transformer

  alias Day4.Info
  alias Day4.Transformer
  alias Day4.DateHelper
  alias Day4.Guard
  alias Day4.TimeSlot
  # who spent the most minutes asleep
  # what minute did they sleep the most of the hour
  # get all the minutes from the slots, generate the ranges and count the one that appears the most

  # test "transform" do
  #   input = [
  #     %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
  #     %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
  #     %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
  #     # %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
  #     # %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
  #     # %Info{date: DateHelper.create_date_time(1518, 11, 01, 23, 58), action: "Guard #99 begins shift"},
  #     # %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
  #     # %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 50), action: "wakes up"},
  #   ]

  #   # expected = {
  #   #   %Guard{
  #   #     number: 10,
  #   #     mins_asleep: 45,
  #   #     time_slots: [
  #   #       %TimeSlot{
  #   #         start: DateHelper.create_date_time(1518, 11, 01, 00, 05)
  #   #         end: DateHelper.create_date_time(1518, 11, 01, 00, 25)
  #   #       },
  #   #       %TimeSlot{
  #   #         start: DateHelper.create_date_time(1518, 11, 01, 00, 30)
  #   #         end: DateHelper.create_date_time(1518, 11, 01, 00, 55)
  #   #       },
  #   #     ]
  #   #   },
  #   #   %Guard{
  #   #     number: 99,
  #   #     mins_asleep: 10
  #   #     time_slots: [
  #   #       %TimeSlot{
  #   #         start: DateHelper.create_date_time(1518, 11, 02, 00, 40)
  #   #         end: DateHelper.create_date_time(1518, 11, 02, 00, 50)
  #   #       },
  #   #     ]
  #   #   },

  #   expected = [
  #     %Guard{
  #       number: 10,
  #       sleep_slots: [
  #         %TimeSlot{
  #           start: DateHelper.create_date_time(1518, 11, 01, 00, 05),
  #           end: DateHelper.create_date_time(1518, 11, 01, 00, 25)
  #         },
  #       ]
  #     }
  #   ]

  #   assert Transformer.transform(input) == expected
  # end

  test "find_guard_number" do
    assert Transformer.find_guard_number("Guard #99 begins shift") == 99
    assert Transformer.find_guard_number("Guard #9 begins shift") == 9
    assert Transformer.find_guard_number("Guard #1234 begins shift") == 1234
  end

  test "order_by_date" do
    input = [
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 23, 58), action: "Guard #99 begins shift"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 50), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
    ]

    expected = [
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 01, 23, 58), action: "Guard #99 begins shift"},
      %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
      %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 50), action: "wakes up"},
    ]

    assert Transformer.order_by_date(input) == expected
  end
end
