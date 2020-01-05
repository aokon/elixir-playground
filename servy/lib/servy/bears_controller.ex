defmodule Servy.BearsController do
  alias Servy.Conv
  alias Servy.Bear
  alias Servy.Wildthings

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_polar/1)
      |> Enum.map(&bear_item/1)
      |> Enum.join()

    %Conv{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %Conv{conv | status: 200, resp_body: "<h1>#{bear.name} - #{bear.type}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{conv | status: 201, resp_body: "Created a #{type} bear named #{name} !"}
  end

  def destroy(conv, %{"id" => id}) do
    %Conv{conv | status: 200, resp_body: "Deleted bear #{id}"}
  end
end
