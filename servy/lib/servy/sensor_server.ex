defmodule Servy.SensorServer do

  @name :sensor_server
  @scheduler_interval :timer.seconds(10)

  use GenServer

  # Client Interface

  def start do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def get_sensor_data do
    GenServer.call @name, :get_sensor_data
  end

  # Server Callbacks

  def init(_state) do
    initial_state = run_tasks_to_get_sensor_data()
    schedule_refresh()
    {:ok, initial_state}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:refresh, _state) do
    new_state = run_tasks_to_get_sensor_data()
    schedule_refresh()
    {:noreply, new_state}
  end

  # NOTE: When custom handle_info is provided the default handler for unexpected
  # messages is over-written.In this case besides custom handle_info for specific message,
  # you will need to provide handle_info for other unexpected messages.
  def handle_info(unexpected, state) do
    IO.puts "Unexpected message: #{unexpected}"
    {:noreply, state}
  end

  defp schedule_refresh() do
    Process.send_after(self(), :refresh, @scheduler_interval)
  end

  defp run_tasks_to_get_sensor_data do
    IO.puts "Running tasks to get sensor data..."

    task = Task.async(fn -> Servy.Tracker.get_location("bigfoot") end)

    snapshots =
      ["cam-1", "cam-2", "cam-3"]
      |> Enum.map(&Task.async(fn -> Servy.VideoCam.get_snapshot(&1) end))
      |> Enum.map(&Task.await/1)

    where_is_bigfoot = Task.await(task)

    %{snapshots: snapshots, location: where_is_bigfoot}
  end
end
