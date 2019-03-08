defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and dispatching to various functions...
  """
  import Issues.TableFormatter, only: [print_table_form_colums: 2]

  @default_count 4

  def main(argv) do
    argv
    |> parse_arguments
    |> process
  end

  def parse_arguments(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_ascending_order()
    |> last(count)
    |> print_table_form_colums(["number", "created_at", "title"])
    |> IO.inspect()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    message = Map.get(error, "message")
    IO.puts("Error: There was an issue during fetching from Github: #{message}")
    System.halt(2)
  end

  def sort_into_ascending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] <= i2["created_at"]
    end)
  end

  def last(list, count) do
    list
    |> Enum.reverse
    |> Enum.take(count)
    |> Enum.reverse
  end

  defp args_to_internal_representation([user, project, count]),
    do: {user, project, String.to_integer(count)}

  defp args_to_internal_representation([user, project]),
    do: {user, project, @default_count}

  defp args_to_internal_representation(_), do: :help
end
