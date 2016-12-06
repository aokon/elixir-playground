defmodule CustomTimes do
  def double(value), do: value * 2

  def triple(value), do: value * 3

  def quadupe(value), do: double(value) * double(value)
end

defmodule Message do
  def hello(content \\ "Welcome!!"), do: IO.puts("Hello!! #{content}")
end
