defmodule Servy do
  use Application

  def start(_type, _args) do
    IO.puts "Starting the app..."
    Servy.Supervisor.start_link()
  end
end
