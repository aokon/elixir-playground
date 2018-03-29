defmodule IslandsInterfaceWeb.GameChannel do
  use IslandsInterfaceWeb, :channel

  alias IslandsEngine.{Game, GameSupervisor}

  def join("game:" <> _player, _payload, socket) do
    {:ok, socket}
  end
end
