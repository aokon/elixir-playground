defmodule Servy.Bear do
  @derive Jason.Encoder
  defstruct id: nil, name: "", type: "", hibernating: false

  def is_polar(bear) do
    bear.type == "Polar"
  end
end
