defmodule Servy.PledgeServer do
  use GenServer

  @name :pledge_server

  def start_link(initial_state \\ []) do
    IO.puts("Starting the pledge server...")
    GenServer.start_link(__MODULE__, initial_state, name: @name)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  # Client API

  def recent_pledges do
    GenServer.call(__MODULE__, :recent_pledges)
  end

  def total_pledged do
    GenServer.call(__MODULE__, :total_pledges)
  end

  def create_pledge(name, amount) do
    GenServer.cast(__MODULE__, {:create_pledges, name, amount})
  end

  # Server API

  def handle_call(:recent_pledges, _from, state) do
    {:reply, Enum.take(state, 3), state}
  end

  def handle_call(:total_pledges, _from, state) do
    total_pledges =
      Enum.take(state, 3)
      |> Enum.reduce(0, fn {_name, amount}, acc -> amount + acc end)

    {:reply, total_pledges , state}
  end

  def handle_cast({:create_pledges, name, amount}, state) do
    new_state = [{name, amount} | state]
    {:noreply, new_state}
  end
end
