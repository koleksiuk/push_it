use Mix.Config

config :push_it, PushIt.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false

config :push_it, PushIt.Repo,
  database: "push_it",
  username: "konole",
  password: "",
  hostname: "localhost"

config :push_it_gcm, url: "http://localhost:7333"

# Enables code reloading for development
config :phoenix, :code_reloader, true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
