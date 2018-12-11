defmodule Day4.TimeSlotGenerator do
  @moduledoc """
  Given a list of InputLine structs, transform it into TimeSlot data per guard to show us all the times the guard fell asleep over a given period.
  """

  alias Day4.InputLine, as: I
  alias Day4.TimeSlot

  @doc """
  Given a list of InputLine structs change them into a list of TimeSlots
  ordered by the earliest date then ascending.
  """
  def run(lines) do
    lines
    |> transform([], nil)
    |> Enum.sort_by(&{&1.guard, &1.start})
  end

  @doc """
  Match on a guard and a pair of asleep / awake lines. Make a new TimeSlot for
  that guard and pass on the current guard number for the next match (sometimes we get several
  sets of asleep / awake pairs for one guard row).
  """
  def transform([%I{action: "Guard" <> _} = guard_line,
                %I{action: "falls" <> _} = start_line,
                %I{action: "wakes" <> _} = finish_line |
                rest],
                slots,
                _) do
    guard_number = find_guard_number(guard_line.action)
    slot = %TimeSlot{guard: guard_number, start: start_line.date, end: finish_line.date}
    transform(rest, [slot | slots], guard_number)
  end

  @doc """
  Match on 2 guard rows following each other. We disregard the first guard, since it has no
  awake / asleep pairs attached to it then rerun the pattern match from the new guard onwards.
  """
  def transform([%I{action: "Guard" <> _},
                %I{action: "Guard" <> _} = guard_line2 |
                rest],
                slots,
                _) do
    transform([guard_line2 | rest], slots, nil)
  end

   @doc """
   Match on a pair of asleep / awake and attach to the guard we last found.
   """
   def transform([%I{action: "falls" <> _} = start_line,
                %I{action: "wakes" <> _} = finish_line |rest],
                slots,
                guard_number) do
    slot = %TimeSlot{guard: guard_number, start: start_line.date, end: finish_line.date}
    transform(rest, [slot | slots], guard_number)
  end

  @doc """
  Match on a guard and a wakes, which is an invalid state. We always want to have a falls
  asleep followed by a wakes. Disregard this set and pattern match on the rest of the set.
  We might get a valid awake / sleep pair next for this guard so we want to remember the
  guard number.
  """
  def transform([%I{action: "Guard" <> _} = guard_line,
                %I{action: "wakes" <> _} |
                rest],
                slots,
                _) do
    guard_number = find_guard_number(guard_line.action)
    transform(rest, slots, guard_number)
  end

  def transform([], slots, _), do: slots

  @doc """
  Given a string for an 'action' return the guard number if it's present.

  ## Examples
    iex> Day4.TimeSlotGenerator.find_guard_number("Guard #99 begins shift")
    99
    iex> Day4.TimeSlotGenerator.find_guard_number("falls asleep")
    nil
  """
  def find_guard_number(input) do
    case Regex.run(~r/#+([0-9][^\s]*)/, input) do
      [_ , match] -> String.to_integer(match)
      _ -> nil
    end
  end
end
