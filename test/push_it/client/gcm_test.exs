defmodule PushIt.Client.GCMTest do
  use ExUnit.Case, async: false

  import Mock

  test "it works" do
    { :ok, _pid } = GenServer.start_link(
      PushIt.Client.GCM, nil, []
    )
  end

  test "gcm request is done" do
    { :ok, pid } = GenServer.start_link(
      PushIt.Client.GCM, %PushIt.Client.GCM.Config{url: "test"}, []
    )

    push = %PushIt.Notifier.Push{ platform: :android, tokens: ["test"], payload: %{a: "b"} }

    gcm_push = %PushIt.Client.GCM.Push{ struct: push, url: "test" }

    with_mock PushIt.Client.GCM.Request, [
      call: fn(_push) -> %HTTPotion.Response{status_code: 200, body: "{}"} end
    ] do
      PushIt.Client.GCM.push(pid, push)

      assert called PushIt.Client.GCM.Request.call(gcm_push)
    end
  end
end
