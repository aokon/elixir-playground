defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_arguments: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_arguments(["-h", "dummy"]) == :help
    assert parse_arguments(["--help", "lorem"]) == :help
  end
end
