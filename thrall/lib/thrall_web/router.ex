defmodule ThrallWeb.Router do
  use ThrallWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {ThrallWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ThrallWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/messages", MessageController
    resources "/users", UserController
    live "/counter", CounterLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", ThrallWeb do
  #   pipe_through :api
  # end
end
