use Mix.Config

config :push_it, PushIt.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :push_it, PushIt.Repo,
  database: "push_it_test",
  username: "konole",
  password: "",
  hostname: "localhost"

config :push_it_gcm, url: "http://localhost:7333"

# Print only warnings and errors during test
config :logger, level: :warn
