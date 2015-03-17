defmodule PushIt.Application do
  use Ecto.Model

  schema "applications" do
    field :name, :string
    field :gcm_api_key, :string
    timestamps
  end
end
