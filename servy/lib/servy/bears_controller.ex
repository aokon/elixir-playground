defmodule Servy.BearsController do
  alias Servy.Conv
  alias Servy.Wildthings

  @templates_path Path.expand("templates", File.cwd!())

  def index(conv) do
    bears = Wildthings.list_bears()

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{conv | status: 201, resp_body: "Created a #{type} bear named #{name} !"}
  end

  def destroy(conv, %{"id" => id}) do
    %Conv{conv | status: 200, resp_body: "Deleted bear #{id}"}
  end

  defp render(conv, template, bindings) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %Conv{conv | status: 200, resp_body: content}
  end
end
