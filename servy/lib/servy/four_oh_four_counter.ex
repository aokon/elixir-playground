defmodule Servy.FourOhFourCounter do
  @name :four_oh_four_counter

  alias Servy.GenericServer

  def start do
    GenericServer.start(__MODULE__, %{}, @name)
  end

  def handle_call({:get_count, path}, state) do
    {state[path], state}
  end

  def handle_call({:get_counts}, state) do
    {state, state}
  end

  def handle_cast({:bump_count, path}, state) do
    counter = state[path] || 0
    Map.put(state, path, counter + 1)
  end

  def handle_cast({:clear}, _state) do
    %{}
  end

  # Public API

  def bump_count(path) do
    GenericServer.cast(@name, {:bump_count, path})
  end

  def get_count(path) do
    GenericServer.call(@name, {:get_count, path})
  end

  def get_counts do
    GenericServer.call(@name, {:get_counts})
  end

  def clear do
    GenericServer.cast(@name, {:clear})
  end
end
