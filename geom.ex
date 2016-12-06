defmodule Geom do
  def area({shape, a, b}) do
    case shape do
      :retrangle -> a * b
      :triangle -> a * b / 2.0
      :ellipse -> :math.pi * a * b
    end
  end

  #defp area(:retrangle, width, height) when (is_number(width) and width >= 0) and
    #(is_number(height) and height >= 0) do

    #width * height
  #end

  #defp area(:triangle, width, height) when (is_number(width) and width >= 0) and
    #(is_number(height) and height >= 0) do

    #width * height / 2.0
  #end

  #defp area(:ellipse, width, height) when (is_number(width) and width >= 0) and
    #(is_number(height) and height >= 0) do

    #:math.pi * width * height
  #end

  #defp area(_, _, _) do
    #0
  #end
end
