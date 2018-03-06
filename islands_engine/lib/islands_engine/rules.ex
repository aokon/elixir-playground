defmodule IslandsEngine.Rules do
  alias __MODULE__

  defstruct state: :initialized

  def new(), do: %Rules{}

  def check(%Rules{state: :initialized} = state, :add_player),
    do: {:ok, %Rules{state | state: :players_set}}

  def check(_state, _action), do: :error
end
