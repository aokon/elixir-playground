use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :thrall, ThrallWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :thrall, Thrall.Repo,
  username: System.get_env("POSTGRESQL_USERNAME"),
  password: System.get_env("POSTGRESQL_PASSWORD"),
  database: "thrall_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
