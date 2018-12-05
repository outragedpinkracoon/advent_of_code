defmodule Day4.Transformer do
  @moduledoc """
  Given a list of Info structs, get data about the guards from it
  """

  alias Day4.TimeSlot

  @doc """
  Given a list of Info structs change them into a list of TimeSlots
  """
  def transform([h|t]) do
    number = find_guard_number(h.action)
    [first, second | rest] = t

    slot = %TimeSlot{guard: number, start: first.date, end: second.date}
    transform(rest, [slot], number)
    |> Enum.sort_by(&{&1.guard, &1.start})
  end

  def transform([h | t], slots, guard_number) do
    case find_guard_number(h.action) do
      nil -> not_on_guard_row(h, t, slots, guard_number)
      number -> on_guard_row(t, slots, number)
    end
  end

  def transform([], slots, _), do: slots

  @doc """
  When on an item that does not contain a guard number, we want to look ahead
  to the next item, since falling asleep and waking up come as pairs and
  represent the start and end of a timeslot and we already have the first
  item in the set that we are currently looking at i.e. waking up
  """
  def not_on_guard_row(item, items, slots, guard_number) do
    [next | rest] = items
    slot = %TimeSlot{guard: guard_number, start: item.date, end: next.date}
    transform(rest, [slot | slots], guard_number)
  end

  @doc """
  When on an item that contains a guard number, we want to look ahead
  to the next two items since falling asleep and waking up come as pairs and
  represent the start and end of a timeslot and we have neither piece of information
  """
  def on_guard_row(items, slots, guard_number) do
    [first, second | rest] = items
    slot = %TimeSlot{guard: guard_number, start: first.date, end: second.date}
    transform(rest, [slot | slots], guard_number)
  end

  @doc """
  Given a string for an 'action' return the guard number if it's present

  ## Examples
    iex> Day4.Transformer.find_guard_number("Guard #99 begins shift")
    99
    iex> Day4.Transformer.find_guard_number("falls asleep")
    nil
  """
  def find_guard_number(input) do
    case Regex.run(~r/#+[0-9][^\s]*/, input) do
      [match] -> parse_number(match)
      nil -> nil
    end
  end

  defp parse_number(input) do
    input
    |> String.replace("#", "")
    |> String.to_integer()
  end
end
