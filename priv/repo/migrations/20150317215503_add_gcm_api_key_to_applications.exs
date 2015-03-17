defmodule PushIt.Repo.Migrations.AddGcmApiKeyToApplications do
  use Ecto.Migration

  def change do
    alter table(:applications) do
      add :gcm_api_key, :string
    end
  end
end
