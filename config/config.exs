# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :balderdash,
  ecto_repos: [Balderdash.Repo]

# Configures the endpoint
config :balderdash, BalderdashWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6GirKSIdTuRY0OD5mkwi+VfobYZ2imnGpw3hk8LFcsQsmFveXgiG21d4nIWTuV0a",
  render_errors: [view: BalderdashWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Balderdash.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "FM3mS7GxI5N6uXsJIhsg3F66y/S8+8zZ"
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
