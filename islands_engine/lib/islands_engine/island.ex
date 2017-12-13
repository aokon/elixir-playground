defmodule IslandsEngine.Island do
  alias __MODULE__

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  def new, do: %Island{coordinates: MapSet.new, hit_coordinates: MapSet.new}

  defp offests(:square), do: [{0,0}, {0,1}, {1,0}, {1,1}]
  defp offests(:atol), do: [{0,0}, {0,1}, {1,1}, {2,1}, {2,2}]
  defp offests(:dot), do: [{0,0}]
end
