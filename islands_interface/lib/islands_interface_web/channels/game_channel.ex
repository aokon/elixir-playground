defmodule IslandsInterfaceWeb.GameChannel do
  use IslandsInterfaceWeb, :channel

  alias IslandsEngine.{Game, GameSupervisor}

  def join("game:" <> _player, _payload, socket) do
    {:ok, socket}
  end

  # Playground with channels \o/

  def handle_in("hello", payload, socket) do
    # payload = %{message: "We forced this error"}
    {:reply, {:ok, payload}, socket}
    # {:reply, {:error, payload}, socket}
  end

  def handle_in("event", payload, socket) do
    push socket, "emits_event", payload
    {:noreply, socket}
  end

  def handle_in("broadcast", payload, socket) do
    broadcast! socket, "emits_event", payload
    {:noreply, socket}
  end

  # Game logic

  def handle_in("new_game", _paylaod, socket) do
    "game:" <> player = socket.topic
    case GameSupervisor.start_game(player) do
      {:ok, _pid} ->
        {:reply, :ok, socket}
      {:error, reason} ->
        {:reply, {:error, %{reason: inspect(reason)}}, socket}
    end
  end

  def handle_in("add_player", player, socket) do
    case Game.add_player(via(socket.topic), player) do
      :ok ->
        broadcast! socket, "player_added", %{message: "New player was added: " <> player}
        {:noreply, socket}
      {:error, reason} ->
        {:reply, {:error, %{reason: inspect(reason)}}, socket}
      :error ->
        {:reply, :error, socket}
    end
  end

  def handle_in("position_island", payload, socket) do
    %{"player" => player, "island" => island, "row" => row, "col" => col} = payload
    player = String.to_existing_atom(player)
    island = String.to_existing_atom(island)

    case Game.position_island(via(socket.topic), player, island, row, col) do
      :ok -> {:reply, :ok, socket}
      _ -> {:reply, :error, socket}
    end
  end

  def handle_in("set_islands", player, socket) do
    player = String.to_existing_atom(player)

    case Game.set_island(via(socket.topic), player) do
      {:ok, board} ->
        broadcast! socket, "player_set_islands", %{player: player}
        {:reply, {:ok, %{board: board}}, socket}
      _ -> {:reply, :error, socket}
    end
  end

  defp via("game:" <> player), do: Game.via_tupple(player)
end
