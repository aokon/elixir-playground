defmodule Subscriber do
  defstruct name: "", paid: false
end

defmodule Customer do
  defstruct name: "", company: ""
end

defmodule Report do
  defstruct owner: %Customer{}, details: "", severity: 1
end
