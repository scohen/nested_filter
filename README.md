# NestedFilter

[![Build Status](https://travis-ci.org/treble37/nested_filter.svg?branch=master)](https://travis-ci.org/treble37/nested_filter)

## The Problem

You have a nested map (or a struct that you converted to a nested map) and you want to remove ALL the keys with specific values such as nil.

##### Example: Remove all the map keys with nil values

```elixir
nested_map = %{a: 1, b: %{c: nil, d: nil}, c: nil}

Map.drop(nested_map, [:c, :d])
# => %{a: 1, b: %{c: nil, d: nil}}

# But you actually wanted:
# => %{a: 1}
```

## The Solution: NestedFilter

NestedFilter drills down into a nested map and can do any of the following:

1. filters out keys according to user specified values.
2. filters out values according to user specified keys.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nested_filter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:nested_filter, "~> 0.1.4"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nested_filter](https://hexdocs.pm/nested_filter).


## Usage

By default, when removing user specified values, empty values will be preserved
(see Case 1 below). You can add empty values to the user specified values list
if you wish those "empty values" (e.g., empty maps) to be removed.

### NestedFilter.drop_by_value

```elixir
# Case 1: Remove the nil values from a nested map, preserving empty map values

nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
NestedFilter.drop_by_value(nested_map, [nil])

# => %{a: 1, b: %{n: 2}, c: %{p: %{}, s: %{t: 2, u: 3}} }

# Case 2: Remove the nil values from a nested map, removing empty map values

nested_map = %{a: 1, b: %{m: nil, n: 2}, c: %{p: %{q: nil, r: nil}, s: %{t: 2, u: 3}} }
NestedFilter.drop_by_value(nested_map, [nil, %{}])
# => %{a: 1, b: %{n: 2}, c: %{s: %{t: 2, u: 3}} }
```

### NestedFilter.drop_by_key

```elixir
# Case 1: Remove values from a nested map by key

nested_map = %{a: 1, b: %{a: 2, b: 3}, c: %{a: %{a: 1, b: 2}, b: 2, c: %{d: 1, e: 2}}}
assert NestedFilter.drop_by_key(nested_map, [:a]) == %{b: %{b: 3},c: %{b: 2, c: %{d: 1, e: 2}}}
```

You can browse the tests for more usage examples.
