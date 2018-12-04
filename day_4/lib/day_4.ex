defmodule Day4 do
  @data_path Path.expand("data", File.cwd!)
  
  alias Day4.Info
  
  def run(filename) do
    read_file(filename)
    |> parse
  end
  
  @doc """
  Given a filename that resides in the data directory, returns the contents
  of the file
  """
  def read_file(filename) do
    @data_path
    |> Path.join("/#{filename}.txt")
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
  end

  @doc """
  Given a list of input lines and a container for the output, 
  constructs a struct representing the data for each line
  """
  def parse_lines([h | t], output) do
    [date_part, time_part] = find_date_time(h)
    date = parse_date(date_part, time_part)
    
    action = find_action(h)
    
    [%Info{ date: date, action: action } | parse_lines(t, output)]
  end
  
  def parse_lines([], output), do: output
  
  @doc """
  Given the date and time parts of the input string, constructs an 
  Elixir DateTime from it
  
  ## Example
    iex> Day4.parse_date("1518-11-04", "00:46")
    %DateTime{year: 1518, month: 11, day: 04, zone_abbr: "AMT",
              hour: 00, minute: 46, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  """
  def parse_date(date_part, time_part) do
    date_parts = String.split(date_part, "-")
    time_parts = String.split(time_part, ":")
    
    #halp there must be a better way
    year = fetch_as_int(date_parts, 0)
    month = fetch_as_int(date_parts, 1)
    day = fetch_as_int(date_parts, 2)

    hour = fetch_as_int(time_parts, 0)
    minute = fetch_as_int(time_parts, 1)
    
    create_date_time(year, month, day, hour, minute)
  end
  
  @doc """
  Given a year, month, day, hour and minute returns an Elixir DateTime

  ## Example
    iex> Day4.create_date_time(1518, 11, 04, 00, 46)
    %DateTime{year: 1518, month: 11, day: 04, zone_abbr: "AMT",
              hour: 00, minute: 46, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  """
  def create_date_time(y, mo, d, h, mi) do
    %DateTime{year: y, month: mo, day: d, zone_abbr: "AMT",
              hour: h, minute: mi, second: 0, microsecond: {0, 0},
              utc_offset: 0, std_offset: 0, time_zone: "Etc/UTC"}
  end
  
  @doc """
  Given an input string, finds the parts relevant to the date and the time

  ## Example
      iex> Day4.find_date_time("[1518-11-04 00:46] wakes up")
      ["1518-11-04", "00:46"]
  """
  def find_date_time(item) do
    Regex.named_captures(~r/\[(?<part>.*)\]/, item)
    |> Map.fetch!("part")
    |> String.split(" ")
  end
  
  @doc """
  Given an input string, finds the parts relevant to the action of the guard

  ## Example
      iex> Day4.find_action("[1518-11-04 00:46] wakes up")
      "wakes up"
  """
  def find_action(item) do
    String.split(item, "]")
    |> Enum.at(1)
    |> String.trim
  end
  
  @doc """
  Given a list and an index, returns the item at that index
  as an integer
  
  ## Example
      iex>  Day4.fetch_as_int(["1518","11", "04"], 0)
      1518
  """
  def fetch_as_int(part, index) do
    {num, _} = Enum.at(part, index) 
               |> Integer.parse()
    num
  end
end
