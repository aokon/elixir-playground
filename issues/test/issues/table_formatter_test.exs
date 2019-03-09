defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  setup do
    [hello: "world"]
  end

  setup :local_update_for_context

  @sample_test_data [
    [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++c4"],
    [c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2 c4"],
    [c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4"],
    [c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"]
  ]

  @headers [:c1, :c2, :c4]

  defp split_with_tree_columns do
    TF.split_into_columns(@sample_test_data, @headers)
  end

  defp local_update_for_context(_context) do
    [dummy: "Lorem"]
  end

  defp login_as_admin(_context) do
    [admin: true]
  end

  defp set_role_as_editor(_context) do
    [editor: true]
  end

  describe "ExUnit callback usage" do
    setup [:login_as_admin, :set_role_as_editor]

    test "metadata from setup", context do
      assert context[:hello] == "world"
      assert context[:dummy] == "Lorem"
      assert context[:admin]
      assert context[:editor]
    end
  end

  test "split_into_columns" do
    columns = split_with_tree_columns()

    assert length(columns) == length(@headers)
    assert List.first(columns) == ["r1 c1", "r2 c1", "r3 c1", "r4 c1"]
    assert List.last(columns) == ["r1+++c4", "r2 c4", "r3 c4", "r4 c4"]
  end

  test "column_widths" do
    widths = TF.widths_of(split_with_tree_columns())

    assert widths == [5, 6, 7]
  end

  test "correct format string returned" do
    assert TF.format_for([9, 10, 11]) == "~-9s | ~-10s | ~-11s~n"
  end

  test "Output is correct" do
    result =
      capture_io(fn ->
        TF.print_table_form_colums(@sample_test_data, @headers)
      end)

    assert result == """
           c1    | c2     | c4     
           ------+--------+--------
           r1 c1 | r1 c2  | r1+++c4
           r2 c1 | r2 c2  | r2 c4  
           r3 c1 | r3 c2  | r3 c4  
           r4 c1 | r4++c2 | r4 c4  
           """
  end
end
