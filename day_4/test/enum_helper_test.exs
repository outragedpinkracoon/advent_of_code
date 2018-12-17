# credo:disable-for-lines:1
defmodule EnumHelperTest do
  use ExUnit.Case
  doctest Day4.EnumHelper

  alias Day4.EnumHelper

  test "most occuring item" do
    assert EnumHelper.most_occuring_item([1, 2, 3, 2, 4]) == 2
    assert EnumHelper.most_occuring_item([1, 2, 3, 2, 4, 4]) == 4
    assert EnumHelper.most_occuring_item([1]) == 1
    assert EnumHelper.most_occuring_item([22, 11, 44, 56, 78, 49, 11]) == 11
    assert EnumHelper.most_occuring_item([22, 78, 44, 56, 78, 49, 11, 78]) == 78
    assert EnumHelper.most_occuring_item([22, 33]) == 33
  end
end
