# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :thrall,
  ecto_repos: [Thrall.Repo]

# Configures the endpoint
config :thrall, ThrallWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/M3WRGiYkHzPf6lcCfX2/0V16UJkMD95IeJLffESnwcXQjibiObx7PBe90D6wu63",
  render_errors: [view: ThrallWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Thrall.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "YnQka6R+9XXGGJxYJlYw+XOd2LEL3OSD"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
