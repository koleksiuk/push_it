# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :push_it, PushIt.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Th8u1GUK6uK6nC2PEfqMRbgP/8g9E5gl6FxTLs9VcchgM5odFQy3F6dbQLG+9aw7",
  debug_errors: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :push_it_gcm, url: ""

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
