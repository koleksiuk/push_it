defmodule PushIt.NotifierTest do
  use ExUnit.Case, async: false

  import Mock

  test "responds with error if tokens array is empty" do
    push = %PushIt.Notifier.Push{platform: :android, tokens: []}

    assert { :error, :no_tokens } == PushIt.Notifier.push(push)
  end

  test "responds with error when platform is undefined" do
    push = %PushIt.Notifier.Push{platform: :foobar, tokens: ["test"]}

    assert { :error, :unsupported_platform } == PushIt.Notifier.push(push)
  end

  test "responds with ok if tokens array is not empty" do
    push = %PushIt.Notifier.Push{platform: :android, tokens: ["test"]}

    with_mock PushIt.Notifier.Android, [
      push: fn(_push) -> nil end
    ] do
      assert :ok  == PushIt.Notifier.push(push)

      assert called PushIt.Notifier.Android.push(
        %PushIt.Notifier.Push{payload: nil, platform: :android, tokens: ["test"], ttl: nil}
      )
    end
  end

  test "it delegates push to proper push handler" do
  end
end
