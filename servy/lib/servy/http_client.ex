defmodule Servy.HTTPClient do
  @host 'localhost'
  @port 4000

  def get(request) do
    with client_sock = connect(),
         :ok = :gen_tcp.send(client_sock, request),
         response = get_response(client_sock),
    do: {:ok, response}
  end

  def connect() do
    {:ok, client_sock} = :gen_tcp.connect(@host, @port,
                                 [:binary, packet: :raw, active: false])

    client_sock
  end

  def get_response(client_sock) do
    {:ok, response} = :gen_tcp.recv(client_sock, 0)
    :ok = :gen_tcp.close(client_sock)

    response
  end
end
