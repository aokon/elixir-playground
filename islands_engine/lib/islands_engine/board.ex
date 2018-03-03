defmodule IslandsEngine.Board do
  alias IslandsEngine.{Island, Coordinate}

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

  def guess(board, %Coordinate{} = coordinate) do
    board
    |> check_all_islands(coordinate)
    |> guess_response(board)
  end

  defp overlap_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
       key != new_key and Island.overlap?(island, new_island)
    end)
  end

  defp check_all_islands(board, coordinate) do
    Enum.find_value(board, :miss, fn {key, island} ->
      case Island.guess(island, coordinate) do
        {:hit, island} -> {key, island}
        {:miss} -> false
      end
    end)
  end

  defp guess_response({key, island}, board) do
    board = %{board | key => island}
    {:hit, check_forested(board, key), check_win(board), board}
  end
  defp guess_response(:miss, board) do: {:miss, :none, :no_win, board}

  defp check_forested(board, key) do
    case forested?(board, key) do
      true -> key
      false -> :none
    end
  end

  defp forested?(board, key) do
    board
    |> Map.fetch!(key)
    |> Island.forested?()
  end
end
