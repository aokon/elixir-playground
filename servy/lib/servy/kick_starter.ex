defmodule Servy.KickStarter do
  use GenServer

  def start do
    IO.puts "Starting the KickStarter..."
    GenServer.start(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    server_pid = start_http_server()
    {:ok, server_pid}
  end

  def get_server do
    GenServer.call(__MODULE__, :get_server)
  end

  def handle_call(:get_server, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, _server_pid, reason}, _state) do
    IO.puts "HTTPServer exited: #{inspect(reason)}"
    server_pid = start_http_server()
    {:noreply, server_pid}
  end

  defp start_http_server do
    IO.puts "Starting the HTTPServer..."
    spawn_link(Servy.HTTPServer, :start, [4000])
  end
end
