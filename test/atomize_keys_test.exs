defmodule AtomizeKeysTest do
  use ExUnit.Case
  doctest AtomizeKeys

  @map %{[1,2] => true, 2 => true, "key" => true, :another_key => true}
  @string "unchanged string"
  @list [:a, :b, :c]
  @number 4.5

  test "atomizes string keys" do
    atomized_map = AtomizeKeys.atomize_string_keys(@map)
    assert Map.has_key?(atomized_map, :key)
    refute Map.has_key?(atomized_map, "key")
  end

  test "leaves non-string keys unchanged" do
    atomized_map = AtomizeKeys.atomize_string_keys(@map)
    assert Map.has_key?(atomized_map, [1,2])
    assert Map.has_key?(atomized_map, 2)
    assert Map.has_key?(atomized_map, :another_key)
  end

  test "only works on maps" do
    assert "unchanged string" = AtomizeKeys.atomize_string_keys(@string)
    assert [:a, :b, :c] = AtomizeKeys.atomize_string_keys(@list)
    assert 4.5 = AtomizeKeys.atomize_string_keys(@number)
  end
end
