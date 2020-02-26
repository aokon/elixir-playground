defmodule Servy.Plugins do
  require Logger

  alias Servy.Conv
  alias Servy.FourOhFourCounter, as: Counter

  def rewrite_path(%Conv{path: "/wildfire"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conv{path: "/bears?id=" <> id} = conv) do
    %{conv | path: "/bears/#{id}"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv) do
    if Mix.env() == :development do
      IO.inspect(conv)
    end

    conv
  end

  def track404(%Conv{status: 404, path: path} = conv) do
    if Mix.env() != :test do
      Counter.bump_count(path)
      Logger.warn("Something went wrong and we loosing the #{path}!!")
    end

    conv
  end

  def track404(%Conv{} = conv), do: conv

  def emojify(%Conv{status: 200, resp_body: resp_body} = conv) do
    decoration = String.duplicate(">", 5)
    decorated_body = decoration <> "\n" <> resp_body <> "\n" <> decoration

    %{conv | resp_body: decorated_body}
  end

  def emojify(%Conv{} = conv), do: conv
end
