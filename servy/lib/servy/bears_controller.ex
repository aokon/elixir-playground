defmodule Servy.BearsController do
  alias Servy.Conv
  alias Servy.BearsView
  alias Servy.Wildthings

  def index(conv) do
    bears = Wildthings.list_bears()

    %Conv{conv | status: 200, resp_body: BearsView.index(bears)}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    %Conv{conv | status: 200, resp_body: BearsView.show(bear)}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{conv | status: 201, resp_body: "Created a #{type} bear named #{name} !"}
  end

  def destroy(conv, %{"id" => id}) do
    %Conv{conv | status: 200, resp_body: "Deleted bear #{id}"}
  end
end
