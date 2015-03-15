defmodule PushIt.Push.GCM do
  @doc ~S"""
  Encodes given push to GCM JSON Format

  ## Examples

      iex> PushIt.Push.GCM.encode(%PushIt.Notifier.Push{ platform: :android, payload: %{ foo: "bar" } })
      {:ok, "{\"data\":{\"foo\":\"bar\"},\"registration_ids\":[]}"}

  """
  def encode(push) do
    gcm_payload = %{ data: push.payload, registration_ids: push.tokens }

    if push.ttl != nil do
      gcm_payload = Map.put(gcm_payload, :time_to_live, push.ttl)
    end

    gcm_payload |> JSON.Encoder.Helpers.dict_encode
  end
end
