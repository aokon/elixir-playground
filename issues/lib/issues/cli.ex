defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and dispatching to various functions...
  """
  @default_count 4

  def run(argv) do
    parse_arguments(argv)
  end

  def parse_arguments(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  defp args_to_internal_representation([user, project, count]),
    do: {user, project, String.to_integer(count) }

  defp args_to_internal_representation([user, project]),
    do: {user, project, @default_count }

  defp args_to_internal_representation(_), do: :help
end
