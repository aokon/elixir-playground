defmodule Servy.HTTPClient do
  @host 'localhost'
  @port 4000

  def get(request) do
    with {:ok, client_sock} <- connect(),
         :ok <- :gen_tcp.send(client_sock, request),
         {:ok, response} <- get_response(client_sock)
    do
      {:ok, response}
    else
      error -> error
    end
  end

  def connect() do
    :gen_tcp.connect(@host, @port, [:binary, packet: :raw, active: false])
  end

  def get_response(client_sock) do
    with {:ok, response} <- :gen_tcp.recv(client_sock, 0),
         :ok <- :gen_tcp.close(client_sock)
    do
      {:ok, response}
    else
      error -> error
    end
  end
end
