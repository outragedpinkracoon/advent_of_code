# credo:disable-for-lines:1
defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "run" do
    expected = %{10 => 50, 99 => 30}

    assert Day4.run("test_input") == expected
  end
end
