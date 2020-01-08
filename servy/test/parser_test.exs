defmodule ParserTest do
  use ExUnit.Case, async: true
  doctest Servy.Parser

  alias Servy.Parser

  test "parses a list of headers into a map" do
    header_lines = ["A: 1", "B: 2"]

    headers = Parser.parse_headers(header_lines)

    assert headers == %{"A" => "1", "B" => "2"}
  end
end
