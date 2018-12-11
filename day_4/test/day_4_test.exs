# credo:disable-for-lines:1
defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "run" do
    assert Day4.run("test_input") == 240
  end
end
