defmodule Servy.FourOhFourCounter do
  @name :four_oh_four_counter

  def start do
    pid = spawn(__MODULE__, :listen_loop, [])
    Process.register(pid, @name)
    pid
  end

  def listen_loop(state \\ %{}) do
    receive do
      {:bump_count, path} ->
        counter = state[path] || 0
        state = Map.put(state, path, counter + 1)
        listen_loop(state)

      {sender, :get_count, path} ->
        send(sender, {:response, state[path]})
        listen_loop(state)

      {sender, :get_counts} ->
        send(sender, {:response, state})
        listen_loop(state)
    end
  end

  def bump_count(path) do
    send(@name, {:bump_count, path})
  end

  def get_count(path) do
    send(@name, {self(), :get_count, path})
    receive do {:response, value} -> value end
  end

  def get_counts do
    send(@name, {self(), :get_counts})
    receive do {:response, value} -> value end
  end
end
