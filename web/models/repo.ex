defmodule PushIt.Repo do
  use Ecto.Repo, otp_app: :push_it, adapter: Ecto.Adapters.Postgres
end
