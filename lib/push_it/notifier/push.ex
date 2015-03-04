defmodule PushIt.Notifier.Push do
  defstruct platform: nil, payload: nil, tokens: []
end

defimpl String.Chars, for: PushIt.Notifier.Push do
  def to_string(push) do
    inspect push
  end
end
