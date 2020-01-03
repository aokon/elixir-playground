defmodule Servy.Bear do
  defstruct id: nil, name: "", type: "", hibernating: false

  def is_polar(bear) do
    bear.type == "Polar"
  end
end
