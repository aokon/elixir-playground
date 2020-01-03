defmodule Servy.BearsController do
  alias Servy.Conv

  def index(conv) do
    %Conv{conv | status: 200, resp_body: "Yogi, Paddington, Teddy"}
  end

  def show(conv, %{"id" => id}) do
    %Conv{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{conv | status: 201,
                 resp_body: "Created a #{type} bear named #{name} !"}
  end

  def destroy(conv, %{"id" => id}) do
    %Conv{conv | status: 200, resp_body: "Deleted bear #{id}"}
  end
end
