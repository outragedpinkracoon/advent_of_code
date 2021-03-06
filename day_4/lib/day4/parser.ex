defmodule Day4.Parser do
  @moduledoc """
  Just putting it all in here for now.
  """
  @data_path Path.expand("data", File.cwd!)

  alias Day4.DateHelper
  alias Day4.InputLine

  def run(filename) do
    filename
    |> read_file
    |> parse
  end

  def sort_by_date(items) do
    items
    |> Enum.sort_by(
      fn i -> {
        i.date.year, i.date.month, i.date.day, i.date.hour, i.date.minute, i.date.second
      }
    end)
  end

  @doc """
  Given a filename that resides in the data directory, returns the contents.
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
    |> sort_by_date
  end

  @doc """
  Given a list of input lines and a container for the output,
  constructs a struct representing the data for each line.
  """
  def parse_lines([h | t], output) do
    [date_part, time_part] = find_date_time(h)
    date = parse_date_time(date_part, time_part)

    action = find_action(h)

    [%InputLine{date: date, action: action} | parse_lines(t, output)]
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
  Given an input string, finds the parts relevant to the date and the time.

  ## Example
      iex> Day4.Parser.find_date_time("[1518-11-04 00:46] wakes up")
      ["1518-11-04", "00:46"]
  """
  def find_date_time(item) do
    ~r/\[(.*)\]/
    |> Regex.run(item)
    |> captured_match
    |> String.split(" ")
  end

  @doc """
  Given an input string, finds the parts relevant to the action of the guard.

  ## Example
      iex> Day4.Parser.find_action("[1518-11-04 00:46] wakes up")
      "wakes up"
  """
  def find_action(item) do
    item
    |> String.split("]")
    |> captured_match
    |> String.trim
  end

  defp captured_match([_, capture]) do
    capture
  end

end
