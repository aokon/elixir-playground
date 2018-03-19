defmodule IslandsEngine.GameSupervisor do
  use Supervisor

  alias IslandsEngine.Game

  def start_link(_options),
    do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok),
    do: Supervisor.init([Game], strategy: :simple_one_for_one)

  def start_game(name),
    do: Supervisor.start_child(__MODULE__, [name])
end
