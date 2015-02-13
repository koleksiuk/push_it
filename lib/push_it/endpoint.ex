defmodule PushIt.Endpoint do
  use Phoenix.Endpoint, otp_app: :push_it

  plug Plug.Static,
    at: "/", from: :push_it

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_push_it_key",
    signing_salt: "Lov06Emz",
    encryption_salt: "3ErRqzxa"

  plug :router, PushIt.Router
end
