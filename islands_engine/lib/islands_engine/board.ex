defmodule IslandsEngine.Board do
  alias IslandsEngine.Island

  def new(), do: %{}

  def position_island(board, key, %Island{} = island) do
    case overlap_existing_island?(board, key, island) do
      true -> {:error, :overlapping_island}
      false -> Map.put(board, key, island)
    end
  end

  def all_islands_positioned?(board) do
    Enum.all?(Island.types, &(Map.has_key?(board, &1)))
  end

  defp overlap_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
       key != new_key and Island.overlap?(island, new_island)
    end)
  end
end
