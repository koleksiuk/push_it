defmodule PushIt.NotifierTest do
  use ExUnit.Case, async: false

  import Mock

  setup do
    app = %PushIt.Application{ gcm_api_key: "test_api_key" }

    {:ok, %{ app: app }}
  end

  test "responds with error if tokens array is empty", context do
    push = %PushIt.Notifier.Push{platform: :android, tokens: []}

    assert { :error, :no_tokens } == PushIt.Notifier.push(push, context[:app])
  end

  test "responds with error when platform is undefined", context do
    push = %PushIt.Notifier.Push{platform: :foobar, tokens: ["test"]}

    assert { :error, :unsupported_platform } == PushIt.Notifier.push(
      push, context[:app]
    )
  end

  test "responds with ok if tokens array is not empty", context do
    push = %PushIt.Notifier.Push{platform: :android, tokens: ["test"]}

    with_mock PushIt.Notifier.Android, [
      push: fn(_push, _app) -> nil end
    ] do
      assert :ok  == PushIt.Notifier.push(push, context[:app])

      assert called PushIt.Notifier.Android.push(
        %PushIt.Notifier.Push{
          payload: nil,
          platform: :android,
          tokens: ["test"],
          message: "",
          ttl: nil,
        }, context[:app]
      )
    end
  end
end
