defmodule Times do
  def double(value), do: value * 2

  def triple(value), do: value * 3

  def quadriple(value), do: double(value) * double(value)
end
