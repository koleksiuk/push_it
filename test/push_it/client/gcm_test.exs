defmodule PushIt.Client.GCMTest do
  use ExUnit.Case, async: false

  defmodule MockHandler do
    use GenServer

    def start_link(pid) do
      { :ok, _pic } = GenServer.start_link(__MODULE__, [pid], name: :mock_handler)
    end

    def perform(push) do
      GenServer.call(:mock_handler, { :push, push })
    end

    def init([pid]) do
      { :ok, pid }
    end

    def handle_call({ :push, push }, _from, pid) do
      send pid, { :push_received, push }

      { :reply, %HTTPotion.Response{status_code: 200, body: "{}"}, pid }
    end
  end

  test "it starts" do
    { :ok, _pid } = GenServer.start_link(PushIt.Client.GCM, nil, [])
  end

  test "gcm request is done" do
    { :ok, pid } = GenServer.start_link(
      PushIt.Client.GCM, %PushIt.Client.GCM.Config{url: "test"}, []
    )

    push = %PushIt.Notifier.Push{ platform: :android, tokens: ["test"], payload: %{a: "b"} }

    gcm_push = %PushIt.Client.GCM.Push{ struct: push, url: "test" }

    { :ok, _handler } = MockHandler.start_link(self)

    PushIt.Client.GCM.push(pid, push, MockHandler)

    assert_receive({ :push_received, ^gcm_push })
  end
end
