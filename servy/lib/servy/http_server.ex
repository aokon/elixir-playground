defmodule Servy.HTTPServer do
  alias Servy.Handler

  @config [:binary, packet: :raw, active: false, reuseaddr: true]

  def start(port) when is_integer(port) and port > 1023 do
    {:ok, listen_sock} = :gen_tcp.listen(port, @config)

    IO.puts "Listening on #{port} port...."

    accept_loop(listen_sock)
  end

  def accept_loop(listen_sock) do
    {:ok, client_sock} = :gen_tcp.accept(listen_sock)
    serve(client_sock)
    accept_loop(listen_sock)
  end

  def serve(client_sock) do
    client_sock
    |> read_request()
    |> Handler.handle()
    |> write_response(client_sock)
  end

  def read_request(client_sock) do
    {:ok, request} = :gen_tcp.recv(client_sock, 0)

    IO.puts "Received request #{request}...\n"
    IO.puts request

    request
  end

  def write_response(response, client_sock) do
    :ok = :gen_tcp.send(client_sock, response)

    IO.puts "Sent response...\n"
    IO.puts response

    :ok = :gen_tcp.close(client_sock)
  end
end
