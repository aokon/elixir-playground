defmodule IslandsEngine.Game do
  use GenServer, start: {__MODULE__, :start_link, []}, restart: :transient

  alias IslandsEngine.{Board, Coordinate, Guesses, Island, Rules}

  @players [:player1, :player2]

  def start_link(name) when is_binary(name), do:
    GenServer.start_link(__MODULE__, name, name: via_tupple(name))

  def via_tupple(name), do: {:via, Registry, {Registry.Game, name}}

  def init(name) do
    player1 = %{name: name, board: Board.new(), guesses: Guesses.new()}
    player2 = %{name: nil, board: Board.new(), guesses: Guesses.new()}
    {:ok, %{player1: player1, player2: player2, rules: %Rules{}}}
  end

  def add_player(game, name) when is_binary(name), do:
    GenServer.call(game, {:add_player, name})

  def position_island(game, player, key, row, col) when player in @players, do:
    GenServer.call(game, {:position_islands, player, key, row, col})

  def set_island(game, player) when player in @players, do:
    GenServer.call(game, {:set_islands, player})

  def guess_coordinate(game, player, row, col) when player in @players, do:
    GenServer.call(game, {:guess_coordinate, player, row, col})

  def handle_call({:add_player, name}, _from, state_data) do
    with {:ok, rules} <- Rules.check(state_data.rules, :add_player) do
      state_data
      |> update_player2_name(name)
      |> update_rules(rules)
      |> reply_success(:ok)
    else
      :error -> {:reply, :error, state_data}
    end
  end

  def handle_call({:position_islands, player, key, row, col}, _from, state_data) do
    board = player_board(state_data, player)

    with {:ok, rules} <- Rules.check(state_data.rules, {:position_islands, player}),
         {:ok, coordinate} <- Coordinate.new(row, col),
         {:ok, island} <- Island.new(key, coordinate),
         %{} = board <- Board.position_island(board, key, island)
    do
      state_data
      |> update_board(player, board)
      |> update_rules(rules)
      |> reply_success(:ok)
    else
      :error -> {:reply, :error, state_data}
      {:error, :invalid_coordinate} -> {:reply, {:error, :invalid_coordinate}, state_data}
      {:error, :invalid_island_type} -> {:reply, {:error, :invalid_island_type}, state_data}
      {:error, :overlapping_island} -> {:reply, {:error, :overlapping_island}, state_data}
    end
  end

  def handle_call({:set_islands, player}, _from, state_data) do
    board = player_board(state_data, player)

    with {:ok, rules} <- Rules.check(state_data.rules, {:set_islands, player}),
         true <- Board.all_islands_positioned?(board)
    do
      state_data
      |> update_rules(rules)
      |> reply_success({:ok, board})
    else
      :error -> {:reply, :error, state_data}
      false -> {:reply, {:error, :not_all_islands_positioned}, state_data}
    end
  end

  def handle_call({:guess_coordinate, player, row, col}, _from, state_data) do
    opponent_name = opponent(player)
    opponent_board = player_board(state_data, opponent_name)

    with {:ok, rules} <- Rules.check(state_data.rules, {:guess_coordinate, player}),
         {:ok, coordinate} <- Coordinate.new(row, col),
         {hit_or_miss, forested_island, win_status, opponent_board} <- Board.guess(opponent_board, coordinate),
         {:ok, rules} <- Rules.check(rules, {:win_check, win_status})
    do
      state_data
      |> update_board(opponent_name, opponent_board)
      |> update_guesses(player, hit_or_miss, coordinate)
      |> update_rules(rules)
      |> reply_success({hit_or_miss, forested_island, win_status})
    else
      :error -> {:reply, :error, state_data}
      {:error, :invalid_coordinate} -> {:reply, {:error, :invalid_coordinate}, state_data}
    end
  end

  defp opponent(:player1), do: :player2
  defp opponent(:player2), do: :player1

  defp update_player2_name(state_data, name), do:
    put_in(state_data.player2.name, name)

  defp update_rules(state_data, rules), do:
    %{state_data | rules: rules}

  defp update_board(state_data, player, board), do:
    Map.update!(state_data, player, fn player -> %{player | board: board} end)

  defp reply_success(state_data, reply), do:
    {:reply, reply, state_data}

  defp player_board(state_data, player), do:
    Map.get(state_data, player).board

  defp update_guesses(state_data, player, hit_or_miss, coordinate) do
    update_in(state_data[player].guesses, fn guesses ->
      Guesses.add(guesses, hit_or_miss, coordinate)
    end)
  end
end