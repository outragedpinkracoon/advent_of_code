defmodule Day4Test do
  @moduledoc """
  Tests for Day4.Parser module
  """
  use ExUnit.Case
  doctest Day4.Parser

  alias Day4.Info
  alias Day4.Parser

  test "run" do
    expected = [
      %Info{date: Parser.create_date_time(1518, 11, 04, 00, 46), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 00, 30), action: "falls asleep"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 00, 55), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 04, 00, 02), action: "Guard #99 begins shift"},
      %Info{date: Parser.create_date_time(1518, 11, 02, 00, 50), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 23, 58), action: "Guard #99 begins shift"},
      %Info{date: Parser.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
      %Info{date: Parser.create_date_time(1518, 11, 03, 00, 05), action: "Guard #10 begins shift"},
      %Info{date: Parser.create_date_time(1518, 11, 03, 00, 24), action: "falls asleep"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 00, 00), action: "Guard #10 begins shift"},
      %Info{date: Parser.create_date_time(1518, 11, 05, 00, 55), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 00, 25), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 05, 00, 03), action: "Guard #99 begins shift"},
      %Info{date: Parser.create_date_time(1518, 11, 04, 00, 36), action: "falls asleep"},
      %Info{date: Parser.create_date_time(1518, 11, 01, 00, 05), action: "falls asleep"},
      %Info{date: Parser.create_date_time(1518, 11, 03, 00, 29), action: "wakes up"},
      %Info{date: Parser.create_date_time(1518, 11, 05, 00, 45), action: "falls asleep"},
    ]

    assert Day4.run("test_input") == expected
  end
end
