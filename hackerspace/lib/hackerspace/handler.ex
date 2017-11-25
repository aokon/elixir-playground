defmodule Hackerspace.Handler do

  def call(request) do
    request
    |> format_response()
  end

  def format_response(request) do
    """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 20

      Lorem ipsum
    """
  end
end
