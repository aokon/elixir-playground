defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track404
    |> format_response
  end

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{ method: method, path: path, resp_body: "", status: nil }
  end

  def rewrite_path(%{ path: "/wildfire"} = conv) do
    %{ conv | path: "/wildthings" }
  end

  def rewrite_path(conv), do: conv

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/wildthings") do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  def route(conv, "GET", "/bears") do
    %{ conv | status: 200, resp_body: "Yogi, Paddington, Teddy" }
  end

  def route(conv, "GET", "/bears/" <> id) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  def route(conv, "DELETE", "/bears/" <> id) do
    %{ conv | status: 200, resp_body: "Deleted bear #{id}" }
  end

  def route(conv, _method, path) do
    %{ conv | status: 404, resp_body: "No #{path} here!" }
  end

  defp status_reason(status_code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[status_code]
  end

  def track404(%{ status: 404, path: path} = conv) do
    IO.puts "Something went wrong and we loosing the #{path}!!"
    conv
  end

  def track404(conv), do: conv

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
GET /wildfire HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.inspect Servy.Handler.handle(request)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.inspect Servy.Handler.handle(request)

request = """
DELETE /bears/22 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.inspect Servy.Handler.handle(request)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.inspect Servy.Handler.handle(request)
