defmodule AtomizeKeys do
  @moduledoc """
  Documentation for AtomizeKeys.
  """

  @doc """
  Change string map keys to atoms.

  ## Examples

      iex> AtomizeKeys.atomize_string_keys(%{"a" => 1, "b" => 2})
      %{a: 1, b: 2}

  """
  def atomize_string_keys(map) when is_map(map), do: atomize_keys(map)

  def atomize_string_keys(term) when is_list(term), do: Enum.map(term, &atomize_keys/1)

  def atomize_string_keys(not_a_map), do: not_a_map

  @doc """
  Change atom map keys to strings.

  ## Examples

      iex> AtomizeKeys.stringify_atom_keys(%{a: 1, b: 2})
      %{"a" => 1, "b" => 2}

  """
  def stringify_atom_keys(%_{} = term), do: term

  def stringify_atom_keys(%{} = term), do: stringify_keys(term)

  def stringify_atom_keys(term) when is_list(term), do: Enum.map(term, &stringify_keys/1)

  def stringify_atom_keys(term), do: term

  defp stringify_keys(nil), do: nil
  defp stringify_keys(%_{} = struct), do: struct

  defp stringify_keys(%{} = map) do
    map
    |> Enum.map(fn
      {k, v} when is_atom(k) -> {to_string(k), stringify_keys(v)}
      {k, v} -> {k, stringify_keys(v)}
    end)
    |> Enum.into(%{})
  end

  defp stringify_keys([head | rest]), do: [stringify_keys(head) | stringify_keys(rest)]
  defp stringify_keys(not_a_map), do: not_a_map

  defp atomize_keys(nil), do: nil
  # Structs don't do enumerable and the keys are already atoms
  defp atomize_keys(%_{} = struct), do: struct

  defp atomize_keys(%{} = map) do
    map
    |> Enum.map(fn
      {k, v} when is_binary(k) -> {to_atom(k), atomize_keys(v)}
      {k, v} -> {k, atomize_keys(v)}
    end)
    |> Enum.into(%{})
  end

  defp atomize_keys([head | rest]), do: [atomize_keys(head) | atomize_keys(rest)]
  defp atomize_keys(not_a_map), do: not_a_map

  defp to_atom(string) do
    try do
      String.to_existing_atom(string)
    rescue
      ArgumentError -> String.to_atom(string)
    end
  end
end
