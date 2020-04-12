defmodule Servy.SensorServer do
  defmodule State do
    defstruct scheduler_interval: :timer.seconds(10),
      sensor_data: %{}
  end

  @name :sensor_server

  use GenServer

  # Client Interface

  def start_link(_args) do
    IO.puts "Starting the SensorServer..."
    GenServer.start_link(__MODULE__, %State{}, name: @name)
  end

  def set_refresh_interval(interval_in_ms) do
    GenServer.cast(@name, {:set_refresh_interval, interval_in_ms})
  end

  def get_sensor_data do
    GenServer.call(@name, :get_sensor_data)
  end

  # Server Callbacks

  def init(_state) do
    initial_state = %State{sensor_data: run_tasks_to_get_sensor_data()}
    schedule_refresh(initial_state.scheduler_interval)
    {:ok, initial_state}
  end

  def handle_cast({:set_refresh_interval, interval_in_ms}, state) do
    new_state = %State{state | scheduler_interval: interval_in_ms}
    schedule_refresh(new_state.scheduler_interval)
    {:noreply, new_state}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state.sensor_data, state}
  end

  def handle_info(:refresh, state) do
    new_state = %State{state | sensor_data: run_tasks_to_get_sensor_data()}
    schedule_refresh(new_state.scheduler_interval)
    {:noreply, new_state}
  end

  # NOTE: When custom handle_info is provided the default handler for unexpected
  # messages is over-written.In this case besides custom handle_info for specific message,
  # you will need to provide handle_info for other unexpected messages.
  def handle_info(unexpected, state) do
    IO.puts "Unexpected message: #{unexpected}"
    {:noreply, state}
  end

  defp schedule_refresh(interval) do
    Process.send_after(self(), :refresh, interval)
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
