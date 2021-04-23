# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :phoenix_test, PhoenixTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a6oSBd9TffNs0DU6tryQE0y6js6x0u1oA1NY1jeNjTinmcaV5V2mwNdy+tQfuZJL",
  render_errors: [view: PhoenixTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixTest.PubSub,
  live_view: [signing_salt: "6wHvc86G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
