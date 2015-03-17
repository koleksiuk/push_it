defmodule PushIt.Notifier do
  require Logger
  use GenServer

  # External
  def start_link do
    { :ok, _pid } = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def push(push, app) do
    GenServer.call(__MODULE__, { :push, push, app })
  end

  # Internal
  def init(_) do
    { :ok, nil }
  end

  def handle_call({ :push, push = %PushIt.Notifier.Push{tokens: []}, app }, _from, state) do
    Logger.debug "No tokens passed: #{inspect push}"
    { :reply, { :error, :no_tokens } , state }
  end

  def handle_call({ :push, push = %PushIt.Notifier.Push{platform: platform}, app }, _from, state) do
    case fetch_push_handler(platform) do
      { :ok, nil } ->
        { :reply, :ok, state }
      { :ok, handler } ->
        handler.push(push, app)
        { :reply, :ok, state }
      error_message = { :error, _message } ->
        { :reply, error_message, state }
    end
  end

  defp fetch_push_handler(platform) do
    case platform do
      :apns    -> { :ok, nil }
      :android -> { :ok, PushIt.Notifier.Android }
      :windows -> { :ok, nil }
      _        -> { :error, :unsupported_platform }
    end
  end
end
