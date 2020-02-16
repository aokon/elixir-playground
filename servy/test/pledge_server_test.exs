defmodule PledgeServerTest do
  use ExUnit.Case, async: true

  alias Servy.PledgeServer

  test "creates a pledge and take only three latest" do
    PledgeServer.start()
    PledgeServer.create_pledge("test1", 20)
    PledgeServer.create_pledge("test2", 400)
    PledgeServer.create_pledge("test3", 100)
    PledgeServer.create_pledge("test4", 200)

    recent_pledges = [{"test4", 200}, {"test3", 100}, {"test2", 400}]

    assert PledgeServer.recent_pledges() == recent_pledges
    assert PledgeServer.total_pledged() == 700
  end
end
