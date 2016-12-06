defmodule Outer do
  @name "Dummy name"

  defmodule Inner do
    def call do
      IO.puts "call from Inner"
    end
  end

  def call do
    Inner.call
    IO.puts "call from Outer"
    IO.puts "Welcome #{@name}"
  end
end

defmodule Outer.Task do
  def run do
    IO.puts "run from Outer.Task"
  end
end

Outer.call
Outer.Task.run

IO.puts "========="

defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def add_1([]), do: []
  def add_1([head|tail]), do: [head + 1 | add_1(tail)]

  def map([], _func), do: []
  def map([ head | tail ], fun), do: [fun.(head) | map(tail, fun)]

  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)
end
