defmodule PushIt.Notifier.Push do
  defstruct platform: nil, payload: nil, tokens: [], ttl: nil
end

defimpl String.Chars, for: PushIt.Notifier.Push do
  def to_string(push) do
    inspect push
  end
end

defimpl JSON.Encoder, for: PushIt.Notifier.Push do
  def encode(push) do
    encoder = case push.platform do
      :android -> PushIt.Push.GCM
      _        -> nil
    end

    encoder.encode(push)
  end
end
