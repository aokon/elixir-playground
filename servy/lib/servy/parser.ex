defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_lines | header_lines] = String.split(top, "\n")

    [method, path, _] = String.split(request_lines, " ")
    params = parse_params(params_string)
    headers = parse_headers(header_lines, %{})

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_params(params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers
end
