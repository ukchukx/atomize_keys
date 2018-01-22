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
  def atomize_string_keys(map) when is_map(map) do
    atomize_keys(map)
  end
  def atomize_string_keys(not_a_map), do: not_a_map

  defp atomize_keys(nil), do: nil
  defp atomize_keys(struct = %{__struct__: _}), do: struct # Structs don't do enumerable and the keys are already atoms
  defp atomize_keys(map = %{}) do
    map
    |> Enum.map(fn
      {k, v} when is_binary(k) -> {String.to_atom(k), atomize_keys(v)}
      {k, v} -> {k, atomize_keys(v)}
    end)
    |> Enum.into(%{})
  end
  defp atomize_keys([head | rest]), do: [atomize_keys(head) | atomize_keys(rest)]
  defp atomize_keys(not_a_map), do: not_a_map
end
