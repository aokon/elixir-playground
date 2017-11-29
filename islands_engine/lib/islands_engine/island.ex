defmodule IslandsEngine.Island do
  alias __MODULE__

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  def new, do: %Island{coordinates: MapSet.new, hit_coordinates: MapSet.new}
end
