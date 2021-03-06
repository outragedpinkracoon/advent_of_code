defmodule Day4.TotalSleep do
  @moduledoc """
  Analyzes the input from TimeSlot information and works out some interesting facts.
  """

  @doc """
  Given a list of TimeSlot structs, returns a map where the keys are the guard number
  and the values are the total time that guard spent asleep
  e.g. %{ 10 => 30, 99 => 15 } would show that guard number 10 spent 30 minutes asleep
  and guard number 99 spent 15 minutes asleep.
  """
  def by_guard([slot | t]) do
    result = Map.put(%{}, slot.guard, slot.mins_asleep)
    by_guard(result, t)
  end

  @doc """
  Given a current map to return and the set of TimeSlots to interrogate,
  check to see if the guard already has an entry in the result set. If so, update
  the value otherwise insert the new value. Then continue on the rest of the set of
  TimeSlots.
  """
  def by_guard(result, [slot | t]) do
    {_, updated} = Map.get_and_update(result, slot.guard, fn current_value ->
      value = case current_value do
        nil -> slot.mins_asleep
        _ -> slot.mins_asleep + current_value
      end
      {current_value, value}
    end)

    updated
    |> by_guard(t)
  end

  def by_guard(result, []), do: result
end
