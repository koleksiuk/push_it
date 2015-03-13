defmodule PushIt.Client.GCMTest do
  use ExUnit.Case

  test "it works" do
    { :ok, _pid } = GenServer.start_link(
      PushIt.Client.GCM, nil, name: :gcm_client
    )
  end
end
