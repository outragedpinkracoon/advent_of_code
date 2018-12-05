defmodule Day4.Parser do
  @moduledoc """
  Just putting it all in here for now
  """
  @data_path Path.expand("data", File.cwd!)

  alias Day4.Info
  alias Day4.DateHelper

  @doc """
  Given a filename that resides in the data directory, returns the contents
  of the file
  """
  def read_file(filename) do
    @data_path
    |> Path.join("/#{ filename }.txt")
    |> File.read!
  end

  @doc """
  Given the the contents of an input file, splits each line then parses them
  into container structs
  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> parse_lines([])
    |> order_by_date
  end

  @doc """
  Given a list of Info structs, returns them ordered by date
  """
  def order_by_date(items) do
    Enum.sort_by(items, &(&1.date))
  end

  @doc """
  Given a list of input lines and a container for the output,
  constructs a struct representing the data for each line
  """
  def parse_lines([h | t], output) do
    [date_part, time_part] = find_date_time(h)
    date = parse_date_time(date_part, time_part)

    action = find_action(h)

    [%Info{date: date, action: action} | parse_lines(t, output)]
  end

  def parse_lines([], output), do: output

  @doc """
  Given the date and time parts of the input string, constructs an
  Elixir DateTime from it

  ## Example
    iex> Day4.Parser.parse_date_time("1518-11-04", "00:46")
    %DateTime{year: 1518, month: 11, day: 04, zone_abbr: "AMT",
              hour: 00, minute: 46, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  """
  def parse_date_time(date_part, time_part) do
    [year, month, day] = date_part
                         |>String.split("-")
                         |> Enum.map(&String.to_integer(&1))

    [hour, minute] = time_part
                     |> String.split(":")
                     |> Enum.map(&String.to_integer(&1))

    DateHelper.create_date_time(year, month, day, hour, minute)
  end

  @doc """
  Given an input string, finds the parts relevant to the date and the time

  ## Example
      iex> Day4.Parser.find_date_time("[1518-11-04 00:46] wakes up")
      ["1518-11-04", "00:46"]
  """
  def find_date_time(item) do
    ~r/\[(?<part>.*)\]/
    |> Regex.named_captures(item)
    |> Map.fetch!("part")
    |> String.split(" ")
  end

  @doc """
  Given an input string, finds the parts relevant to the action of the guard

  ## Example
      iex> Day4.Parser.find_action("[1518-11-04 00:46] wakes up")
      "wakes up"
  """
  def find_action(item) do
    item
    |> String.split("]")
    |> Enum.at(1)
    |> String.trim
  end

end
