defmodule Servy do
  def call do
    request = """
    GET /wildfire HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    GET /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    DELETE /bears/22 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    GET /bigfoot HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    GET /bears?id=99 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    GET /pages/about HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    GET /pages/faq HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    IO.inspect(Servy.Handler.handle(request))

    request = """
    POST /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 21

    name=Baloo&type=Brown
    """

    IO.inspect(Servy.Handler.handle(request))
  end
end
