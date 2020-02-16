defmodule Servy.SnapshotController do
  alias Servy.Conv
  alias Servy.Fetcher
  alias Servy.VideoCam
  alias Servy.Tracker
  alias Servy.SnapshotView

  def index(conv) do
    snapshots =
      ["cam-1", "cam-2", "cam-3"]
      |> Enum.map(&Fetcher.async(fn -> VideoCam.get_snapshot(&1) end))
      |> Enum.map(&Fetcher.await/1)

    locations_pid = Fetcher.async(fn -> Tracker.get_location("bigfoot") end)
    locations = Fetcher.await(locations_pid)

    %Conv{conv | status: 200, resp_body: SnapshotView.index(snapshots, locations)}
  end
end
