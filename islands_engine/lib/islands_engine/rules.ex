defmodule IslandsEngine.Rules do
  alias __MODULE__

  defstruct state: :initialized

  def new(), do: %Rules{}

  def check(_state, _action), do: :error
end
