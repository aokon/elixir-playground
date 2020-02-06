defmodule HandlerTest do
  use ExUnit.Case, async: true

  import Servy.Handler, only: [handle: 1]

  test "DELETE /bears" do
    request = """
    DELETE /bears/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 14\r
           \r
           Deleted bear 1
           """
  end

  test "GET /api/bears" do
    request = """
    GET /api/bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """
    json =
      Servy.Wildthings.list_bears()
      |> Jason.encode!()

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: application/json\r
           Content-Length: 605\r
           \r
           #{json}
           """
  end
end
