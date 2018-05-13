defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_arguments: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_arguments(["-h", "dummy"]) == :help
    assert parse_arguments(["--help", "lorem"]) == :help
  end

  test "returned tree values when there are in the arguments" do
    assert parse_arguments(["test", "test_project", "99"]) == {"test", "test_project", 99}
  end

  test "returned @default_count when there is no issue count in the args" do
    assert parse_arguments(["test", "test_project"]) == {"test", "test_project", 4}
  end
end
