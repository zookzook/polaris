# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :polaris, PolarisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mWSlW+WKvDaOKU3Hh50XN9uekUBuFG9shDSL95C0lPYPfORK77VYXE/bY2XPO83P",
  render_errors: [view: PolarisWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Polaris.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "bO7w7Z8b"]

config :polaris, :generator,
  out: Path.relative_to_cwd("site")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
