defmodule PushIt.Notifier.Android do
  require Logger
  use GenServer

  # External
  def start_link do
    { :ok, _pid } = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def push(push) do
    GenServer.cast(__MODULE__, { :push, push })
  end

  # Internal
  def init(_) do
    { :ok, nil }
  end

  def handle_cast({ :push, push }, state) do
    Logger.info(push)

    { :noreply, state }
  end
end
