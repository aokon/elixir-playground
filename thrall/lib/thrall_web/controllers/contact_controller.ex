defmodule ThrallWeb.ContactController do
  use ThrallWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

