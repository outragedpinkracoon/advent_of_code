# credo:disable-for-lines:1
defmodule ParserTest do
  use ExUnit.Case
  doctest Day4.Parser

  alias Day4.DateHelper
  alias Day4.InputLine
  alias Day4.Parser

  test "reads the input" do
    input = Parser.read_file("test_input")

    expected = """
    [1518-11-04 00:46] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-01 00:55] wakes up
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-02 00:50] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-02 00:40] falls asleep
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-03 00:24] falls asleep
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-05 00:55] wakes up
    [1518-11-01 00:25] wakes up
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-04 00:36] falls asleep
    [1518-11-01 00:05] falls asleep
    [1518-11-03 00:29] wakes up
    [1518-11-05 00:45] falls asleep
    """
    assert input == expected
  end

  test "parse" do
    input = """
    [1518-09-19 00:42] wakes up
    [1518-08-06 00:16] wakes up
    [1518-07-18 00:14] wakes up
    [1518-03-23 00:19] falls asleep
    [1518-03-23 00:00] falls asleep
    [1518-10-12 23:58] Guard #421 begins shift
    """

    expected = [
      %InputLine{date: DateHelper.create_date_time(1518, 03, 23, 00, 00), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 03, 23, 00, 19), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 07, 18, 00, 14), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 08, 06, 00, 16), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 09, 19, 00, 42), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 10, 12, 23, 58), action: "Guard #421 begins shift"},
    ]
    assert Parser.parse(input) == expected
  end

  test "run" do
    expected = [
      %InputLine{date: DateHelper.create_date_time(1518, 03, 23, 00, 19), action: "falls asleep"},
      %InputLine{date: DateHelper.create_date_time(1518, 07, 18, 00, 14), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 08, 06, 00, 16), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 09, 19, 00, 42), action: "wakes up"},
      %InputLine{date: DateHelper.create_date_time(1518, 10, 12, 23, 58), action: "Guard #421 begins shift"},
    ]
    assert Parser.run("test_parser_run") == expected
  end
end
