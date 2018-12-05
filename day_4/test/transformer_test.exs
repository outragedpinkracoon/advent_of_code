# credo:disable-for-lines:1
defmodule TransformerTest do
  use ExUnit.Case
  doctest Day4.Transformer
  
  alias Day4.Info
  alias Day4.Transformer
  alias Day4.DateHelper
  
  test "transform" do
    input = [
      %Info{date: DateHelper.create_date_time(1518, 11, 04, 00, 46), action: "wakes up"},
      %Info{date: DateHelper.create_date_time(1518, 11, 02, 00, 40), action: "falls asleep"},
    ]
    assert Transformer.transform == true
  end
end
