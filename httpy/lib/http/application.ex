defmodule Httpy.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Httpy, port: 8080}
    ]

    opts = [strategy: :one_for_one, name: Httpy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
