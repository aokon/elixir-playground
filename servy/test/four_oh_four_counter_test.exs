defmodule FourOhFourCounterTest do
  use ExUnit.Case

  alias Servy.FourOhFourCounter, as: Counter

  test "reports counts of missing path requests" do
    Counter.start()

    Counter.bump_count("/bigfoot")
    Counter.clear
    Counter.bump_count("/nessie")
    Counter.bump_count("/nessie")
    Counter.bump_count("/bigfoot")
    Counter.bump_count("/nessie")

    assert Counter.get_count("/nessie") == 3
    assert Counter.get_count("/bigfoot") == 1

    assert Counter.get_counts == %{"/bigfoot" => 1, "/nessie" => 3}
  end
end
