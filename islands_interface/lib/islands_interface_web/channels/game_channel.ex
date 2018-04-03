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
end
