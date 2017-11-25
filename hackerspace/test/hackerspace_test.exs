defmodule HackerspaceTest do
  use ExUnit.Case
  doctest Hackerspace

  test "greets the world" do
    assert Hackerspace.hello() == :world
  end
end
