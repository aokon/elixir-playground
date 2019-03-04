defmodule Httpy do
  require Logger

  def start_link(port: port) do
    {:ok, socket} = :gen_tcp.listen(port, active: false, packet: :http_bin, reuseaddr: true)
    Logger.info("Listening at port #{port}....")
    {:ok, spawn_link(Httpy, :accept, [socket])}
  end

  def accept(socket) do
    {:ok, request} = :gen_tcp.accept(socket)

    spawn(fn ->
      body = "Hello world! The time is #{Time.to_string(Time.utc_now())}"

      response = """
      HTTP/1.1 200\r
      Content-Type: text/html\r
      Content-Length: #{byte_size(body)}\r
      \r
      #{body}
      """

      send_response(request, response)
    end)

    accept(socket)
  end

  def send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

   def child_spec(opts) do
    %{id: Httpy, start: {Httpy, :start_link, [opts]}}
   end
end
