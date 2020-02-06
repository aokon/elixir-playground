defmodule Servy.Handler do
  @moduledoc """
    Handles HTTP requests
  """

  import Servy.FileHandler, only: [handle_file: 2]
  import Servy.Parser, only: [parse: 1]
  import Servy.Plugins, only: [log: 1, track404: 1, rewrite_path: 1]

  alias Servy.Conv
  alias Servy.BearsController
  alias Servy.SnapshotController

  @pages_path Path.expand("pages", File.cwd!())

  @doc "Transform the request into a response"
  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track404
    |> format_response
  end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %Conv{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/api/bears"} = conv) do
    Servy.Api.BearsController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    BearsController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/boom"} = _conv) do
    raise "oops!!!"
  end

  def route(%Conv{method: "GET", path: "/sleep"} = conv) do
    :timer.sleep(10000)
    %Conv{conv | status: 200, resp_body: "Woke up!"}
  end

  def route(%Conv{ method: "GET", path: "/snapshots" } = conv) do
    SnapshotController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearsController.show(conv, params)
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearsController.destroy(conv, params)
  end

  def route(%Conv{method: "GET", path: "/pages/" <> file} = conv) do
    @pages_path
    |> Path.join(file <> ".html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    BearsController.create(conv, conv.params)
  end

  def route(%Conv{method: _method, path: path} = conv) do
    %Conv{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: #{conv.resp_content_type}\r
    Content-Length: #{byte_size(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end
end
