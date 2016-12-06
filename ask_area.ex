defmodule AskArea do

  def area do
    input = IO.gets "R)ectangle, T)riangle, or E)llipse: "
    shape = input_to_shape(input)
    {d1, d2} = case shape do
      :retrangle -> get_dimensions("width", "height")
      :triangle -> get_dimensions("base", "height")
      :ellipse -> get_dimensions("major radius", "minor radius")
      _ -> {0, 0}
    end
    calculate(shape, d1, d2)
  end

  def input_to_shape(input) do
    case String.upcase(String.strip(input)) do
      "R" -> :retrangle
      "T" -> :triangle
      "E" -> :ellipse
       _  -> :unknown
    end
  end

  def get_dimensions(a, b) do
    number_a = get_number(IO.gets("Enter #{a}: "))
    number_b = get_number(IO.gets("Enter #{b}: "))
    {number_a, number_b}
  end

  def get_number(input) do
    stripped_input = String.strip(input)
    cond do
      Regex.match?(~r/\A(\d+)\.(\d+)\z/, stripped_input) ->
        String.to_float(stripped_input)
      Regex.match?(~r/\A\d+\z/, stripped_input) ->
        String.to_integer(stripped_input)
      true -> "x"
    end
  end

  def calculate(shape, a, b) do
    cond do
      !is_number(a) or !is_number(b) -> "Both inputs should be numbers"
      a < 0 or b < 0 -> "Both numbers must be grater than zero"
      (shape == :retrangle and a > 0 and b > 0) -> Geom.area({:retrangle, a, b})
      (shape == :triangle and a > 0 and b > 0) -> Geom.area({:triangle, a, b})
      (shape == :ellipse and a > 0 and b > 0) -> Geom.area({:ellipse, a, b})
      shape == :unknown -> "Unknown shape #{shape}"
    end
  end
end
