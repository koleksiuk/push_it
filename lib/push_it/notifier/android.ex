defmodule PushIt.Notifier.Android do
  require Logger
  use GenServer

  # External
  def start_link do
    { :ok, _pid } = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def push(push, %PushIt.Application{ gcm_api_key: api_key }) do
    GenServer.cast(__MODULE__, { :push, %{ push: push, api_key: api_key } })
  end

  # Internal
  def init(_) do
    { :ok, nil }
  end

  def handle_cast({ :push, %{ push: push, api_key: api_key } }, state) do
    worker = :poolboy.checkout(:gcm_client)

    PushIt.Client.GCM.push(worker, push, api_key)

    :poolboy.checkin(:gcm_client, worker)

    { :noreply, state }
  end
end
