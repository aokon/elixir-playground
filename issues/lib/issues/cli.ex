defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and dispatching to various functions...
  """
  @default_count 4

  def run(argv) do
    argv
    |> parse_arguments()
    |> process()
  end

  def parse_arguments(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, _count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> IO.inspect()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts "Error: There was an issue during fetching from Github: #{error[:message]}"
    System.halt(2)
  end

  defp args_to_internal_representation([user, project, count]),
    do: {user, project, String.to_integer(count)}

  defp args_to_internal_representation([user, project]),
    do: {user, project, @default_count}

  defp args_to_internal_representation(_), do: :help
end
