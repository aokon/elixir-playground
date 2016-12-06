defmodule Sum do
  def calculate(0), do: 0
  def calculate(n), do: n + calculate(n-1)
end
