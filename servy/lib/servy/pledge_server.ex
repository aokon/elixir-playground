defmodule Servy.PledgeServer do
  @name __MODULE__

  def start(initial_state \\ []) do
    IO.puts("Starting the pledge server...")
    pid = spawn(__MODULE__, :listen_loop, [initial_state])
    Process.register(pid, @name)
    pid
  end

  def listen_loop(state) do
    receive do
      {:create_pledge, name, amount} ->
        state = [{name, amount} | state]
        listen_loop(state)

      {sender, :recent_pledges} ->
        send(sender, {:response, Enum.take(state, 3)})
        listen_loop(state)

      {sender, :total_pledged} ->
        total_pledged =
          Enum.take(state, 3)
          |> Enum.reduce(0, fn {_name, amount}, acc -> amount + acc end)

        send(sender, {:response, total_pledged})
        listen_loop(state)
    end
  end

  def recent_pledges do
    send(@name, {self(), :recent_pledges})

    receive do
      {:response, recent_pledges} -> recent_pledges
    end
  end

  def total_pledged do
    send(@name, {self(), :total_pledged})

    receive do
      {:response, total_pledged} -> total_pledged
    end
  end

  def create_pledge(name, amount) do
    send(@name, {:create_pledge, name, amount})
  end
end

# pid = Servy.PledgeServer.start()

# send pid, {:create_pledge, "larry", 10}
# send pid, {:create_pledge, "moe", 20}
# send pid, {:create_pledge, "curly", 30}
# send pid, {:create_pledge, "daisy", 40}
# send pid, {:create_pledge, "grace", 50}

# send pid, {self(), :recent_pledges}

# receive do {:response, pledges} -> IO.inspect pledges end
