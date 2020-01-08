defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")
    [request_lines | header_lines] = String.split(top, "\r\n")

    [method, path, _] = String.split(request_lines, " ")
    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  @doc """
  Parses the given params in the format `key1=value1&key2=value2`
  into a map with corresponding key and values.

  ## Examples
      iex> params_string = "name=Baz&type=Brown"
      iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", params_string)
      %{"name" => "Baz", "type" => "Brown"}
      iex> Servy.Parser.parse_params("multipart/form-data", params_string)
      %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  def parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, fn line, acc ->
      [key, value] = String.split(line, ": ")
      Map.put(acc, key, value)
    end)
  end

  # Play with recursion
  # def parse_headers([head | tail], headers) do
  # [key, value] = String.split(head, ": ")
  # headers = Map.put(headers, key, value)
  # parse_headers(tail, headers)
  # end

  # def parse_headers([], headers), do: headers
end
