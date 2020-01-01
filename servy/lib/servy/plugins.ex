defmodule Servy.Plugins do
  require Logger

  def rewrite_path(%{path: "/wildfire"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%{path: "/bears?id=" <> id} = conv) do
    %{conv | path: "/bears/#{id}"}
  end

  def rewrite_path(conv), do: conv

  def log(conv), do: IO.inspect(conv)

  def track404(%{status: 404, path: path} = conv) do
    Logger.warn("Something went wrong and we loosing the #{path}!!")
    conv
  end

  def track404(conv), do: conv

  def emojify(%{status: 200, resp_body: resp_body} = conv) do
    decoration = String.duplicate(">", 5)
    decorated_body = decoration <> "\n" <> resp_body <> "\n" <> decoration

    %{conv | resp_body: decorated_body}
  end

  def emojify(conv), do: conv
end
