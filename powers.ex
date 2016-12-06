defmodule Powers do
  def raisen(_, 0) do
    1
  end

  def raisen(x, 1) do
    x
  end

  def raisen(x, n) when n > 0 do
    x * raisen(x, n - 1)
  end

  def raisen(x, n) when n < 0 do
   1.0 / raisen(x, -n)
  end
end
