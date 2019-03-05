defmodule Httpy.PlugAdapter do
  def dispatch(request, plug) do
    %{headers: headers, full_path: full_path} = Httpy.Server.read_request(request)

    %Plug.Conn{
      adapter: {Httpy.PlugAdapter, request},
      owner: self(),
      path_info: path_info(full_path),
      query_string: query_string(full_path),
      req_headers: headers
    }
    |> plug.call([])
  end

  def send_resp(socket, status, headers, body) do
    response = "HTTP/1.1 #{status}\r\n#{headers(headers)}\r\n#{body}"

    Httpy.Server.send_response(socket, response)
    {:ok, nil, socket}
  end

  def child_spec(plug: plug, port: port) do
    Httpy.Server.child_spec(port: port, dispatch: &dispatch(&1, plug))
  end

  defp headers(headers) do
    Enum.reduce(headers, "", fn {key, value}, acc ->
      acc <> key <> ": " <> value <> "\r\n"
    end)
  end

  defp path_info(full_path) do
    [path | _] = String.split(full_path, "?")
    path |> String.split("/") |> Enum.reject(&(&1 == ""))
  end

  defp query_string([_]), do: ""
  defp query_string([_, query_string]), do: query_string

  defp query_string(full_path) do
    full_path
    |> String.split("?")
    |> query_string
  end
end
