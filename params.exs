defmodule Params do
  def func(p1, p2 \\ 123)

  def func(p1, p2) when p2 === 99 do
    IO.puts "its #{p1} with 99"
  end

  def func(p1, p2) do
    IO.puts "its #{p1} and #{p2}"
  end
end
