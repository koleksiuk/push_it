defmodule PushIt.Notifier.PushTest do
  use ExUnit.Case

  test "it allows to convert GCM push without ttl" do
    p = %PushIt.Notifier.Push{ platform: :android, payload: %{ a: "b" }, tokens: ["test"] }

    expected_push = %{
      "payload" => %{
        "a" => "b"
      },
      "registration_ids" => ["test"]
    }

    { :ok, encoded_push } = JSON.encode(p)

    assert {:ok, expected_push } == JSON.decode(encoded_push)
  end

  test "it allows to convert GCM push with ttl" do
    p = %PushIt.Notifier.Push{ platform: :android, payload: %{ a: "b" }, tokens: ["test"], ttl: 3600 }

    expected_push = %{
      "payload" => %{
        "a" => "b"
      },
      "time_to_live" => 3600,
      "registration_ids" => ["test"]
    }

    { :ok, encoded_push } = JSON.encode(p)

    assert {:ok, expected_push } == JSON.decode(encoded_push)
  end
end
