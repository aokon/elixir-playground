defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and dispatching to various functions...
  """

  def run(argv) do
    parse_arguments(argv)
  end

  def parse_arguments(argv) do
    options = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case options do
      {[help: true], _, _} ->
        :help

      {_, [user, project, count], _} ->
        {user, project, String.to_integer(count)}

      _ ->
        :help
    end
  end
end
