defmodule PushIt.Application do
  use Ecto.Model

  schema "applications" do
    field :name, :string
    timestamps
  end
end
