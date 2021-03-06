defmodule NestedFilterTest do
  use ExUnit.Case
  doctest NestedFilter

  test "can filter out a nested map's keys with nil values" do
    nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
    assert NestedFilter.drop_by_value(nested_map, [nil]) == %{a: 1, b: %{n: 2}, c: %{p: %{}, s: %{t: 2, u: 3}} }
  end

  test "can filter out a nested map's keys with non-nil values" do
    nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
    assert NestedFilter.drop_by_value(nested_map, [2]) == %{a: 1, b: %{m: nil}, c: %{p: %{q: nil, r: nil}, s: %{u: 3}} }
  end

  test "can filter out a nested map's keys with nil and non-nil values" do
    nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
    assert NestedFilter.drop_by_value(nested_map, [nil, 1, 2]) == %{b: %{}, c: %{p: %{}, s: %{u: 3}} }
  end

  test "can filter out a nested map's keys with nil and empty map values" do
    nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
    assert NestedFilter.drop_by_value(nested_map, [nil, %{}]) == %{a: 1, b: %{n: 2}, c: %{s: %{t: 2, u: 3}} }
  end

  test "can filter out a nested map's values by key" do
    nested_map = %{a: 1, b: %{a: 2, b: 3}, c: %{a: %{a: 1, b: 2}, b: 2, c: %{d: 1, e: 2}}}
    assert NestedFilter.drop_by_key(nested_map, [:a]) == %{b: %{b: 3},c: %{b: 2, c: %{d: 1, e: 2}}}
  end

  test "can filter out a nested map's values by multiple keys" do
    nested_map = %{a: 1, b: %{a: 2, b: 3}, c: %{a: %{a: 1, b: 2}, b: 2, c: %{d: 1, e: 2}}}
    assert NestedFilter.drop_by_key(nested_map, [:a, :b]) == %{c: %{c: %{d: 1, e: 2}}}
  end
end
