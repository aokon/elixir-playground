defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track404
    |> emojify
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

  def rewrite_path(%{ path: "/bears?id=" <> id} = conv) do
    %{ conv | path: "/bears/#{id}" }
  end

  def rewrite_path(conv), do: conv

  def route(%{method: "GET", path: "/wildthings"} = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  def route(%{method: "GET", path: "/bears"} = conv) do
    %{ conv | status: 200, resp_body: "Yogi, Paddington, Teddy" }
  end

  def route(%{method: "GET", path: "/bears/" <> id} = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  def route(%{method: "DELETE", path: "/bears/" <> id} = conv) do
    %{ conv | status: 200, resp_body: "Deleted bear #{id}" }
  end

  def route(%{method: _method, path: path} = conv) do
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

  def emojify(%{status: 200, resp_body: resp_body} = conv) do
    decoration = String.duplicate(">", 5)
    decorated_body = decoration <> "\n" <> resp_body <> "\n" <> decoration

    %{conv | resp_body: decorated_body}
  end

  def emojify(conv), do: conv

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

