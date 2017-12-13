defmodule IslandsEngine.Island do
  alias __MODULE__

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  def new, do: %Island{coordinates: MapSet.new, hit_coordinates: MapSet.new}

  defp offests(:square), do: [{0,0}, {0,1}, {1,0}, {1,1}]
  defp offests(:atol), do: [{0,0}, {0,1}, {1,1}, {2,1}, {2,2}]
  defp offests(:dot), do: [{0,0}]
  defp offsets(:l_shape), do: [{0,0}, {1,0}, {2,0}, {2,1}]
  defp offsets(:s_shape), do: [{0,1}, {0,2}, {1,0}, {1,1}]
  defp offsets(_), do: {:error, :invalid_island_type}
end
