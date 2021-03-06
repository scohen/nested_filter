defmodule NestedFilter do
  @moduledoc """
  Documentation for NestedFilter.
  """

  @doc """
  Take a (nested) map and filter out any keys with specified values in the
  filter_values list.
  """
  @spec drop_by_value(map :: map(), filter_values :: list()) :: map()
  def drop_by_value(map, filter_values) do
    cond do
      is_nested_map?(map) ->
        new_map = map
                  |> Enum.reduce(%{}, fn({key, val}, acc) ->
                     Map.put(acc, key, drop_by_value(val, filter_values)) end)
        Map.drop(new_map, filterable_keys(new_map, filter_values))
      is_map(map) ->
        Map.drop(map, filterable_keys(map, filter_values))
      true ->
        map
    end
  end

  @doc """
  Take a (nested) map and filter out any values with specified keys in the
  filter_keys list.
  """
  @spec drop_by_key(map :: map(), filter_keys :: list()) :: map()
  def drop_by_key(map, filter_keys) do
    cond do
      is_nested_map?(map) ->
        new_map = map
                  |> Enum.reduce(%{}, fn({key, val}, acc) ->
                     Map.put(acc, key, drop_by_key(val, filter_keys)) end)
        Map.drop(new_map, filter_keys)
      is_map(map) ->
        Map.drop(map, filter_keys)
      true ->
        map
    end
  end

  defp filterable_keys(map, filter_values) when is_list(filter_values) do
    map
    |> Map.keys
    |> Enum.filter(fn(key) -> Enum.member?(filter_values, map[key]) end)
  end

  defp filterable_keys(map, filter_values), do: map

  defp is_nested_map?(map) do
    cond do
      is_map(map) ->
        map
        |> Enum.any?(fn{key, _} -> is_map(map[key]) end)
      true ->
        false
    end
  end
end
