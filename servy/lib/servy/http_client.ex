defmodule Servy.HTTPClient do
  def get(host, port, path) when is_binary(host) do
    host_as_charlist = host |> String.to_charlist()
    get(host_as_charlist, port, path)
  end

  def get(host, port, path) do
    with {:ok, client_sock} <- connect(host, port),
         :ok <- :gen_tcp.send(client_sock, request(:get, path)),
         {:ok, response} <- get_response(client_sock) do
      {:ok, response}
    else
      error -> error
    end
  end

  def connect(host, port) do
    :gen_tcp.connect(host, port, [:binary, packet: :raw, active: false])
  end

  def get_response(client_sock) do
    with {:ok, response} <- :gen_tcp.recv(client_sock, 0),
         :ok <- :gen_tcp.close(client_sock) do
      {:ok, response}
    else
      error -> error
    end
  end

  def request(:get, path) do
    """
    GET #{path} HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """
  end
end
