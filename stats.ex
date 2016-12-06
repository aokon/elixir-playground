defmodule Stats do
  def minimum(data) do
    [head | tail] = data
    minimum(tail, head)
  end

  def minimum([], result) do
    result
  end

  def minimum([head | tail], result) when result < head do
    minimum(tail, head)
  end

  def minimum([head | tail], _result) do
    minimum(tail, head)
  end

  def maximum(data) do
    [head | tail] = data
    maximum(tail, head)
  end

  def maximum([], result) do
    result
  end

  def maximum([head | tail], result) when result > head do
    maximum(tail, result)
  end

  def maximum([head | tail], _result) do
    maximum(tail, head)
  end

  def range(list) do
    [minimum(list), maximum(list)]
  end
end
