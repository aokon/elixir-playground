defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Bear 1", type: "Polar"},
      %Bear{id: 2, name: "Bear 2", type: "Brown", hibernating: true},
      %Bear{id: 3, name: "Bear 3", type: "Panda"},
      %Bear{id: 4, name: "Bear 4", type: "Grizzly", hibernating: true},
      %Bear{id: 5, name: "Bear 5", type: "Polar"}
    ]
  end
end
