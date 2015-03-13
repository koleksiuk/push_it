defmodule PushIt.Push.GCM do
  def encode(push) do
    gcm_payload = %{ payload: push.payload, registration_ids: push.tokens }

    if push.ttl != nil do
      gcm_payload = Map.put(gcm_payload, :time_to_live, push.ttl)
    end

    gcm_payload |> JSON.Encoder.Helpers.dict_encode
  end
end
