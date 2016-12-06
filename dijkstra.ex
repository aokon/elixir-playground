defmodule Dijkstra do
  def gcd(a, b) do
    cond do
      a === b -> a
      a > b -> gcd(a - b, b)
      a < b -> gcd(a, b - a)
    end
  end
end
