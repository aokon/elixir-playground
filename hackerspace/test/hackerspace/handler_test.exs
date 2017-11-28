defmodule Hackerspace.HandlerTest do
  use ExUnit.Case
  doctest Hackerspace.Handler

  test "returns 200 HTTP status" do
    request = """
    GET / HTTP/1.1
    Host: localhost
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Lorem ipsum
    """

    assert Hackerspace.Handler.call(request) == expected_response
  end
end
