defmodule PushIt.Client.GCM do
  require Logger
  use GenServer

  # External
  def start_link(gcm_config \\ %PushIt.Client.GCMConfig{}) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, gcm_config, [])
  end

  def push(pid, push) do
    GenServer.cast(pid, { :push, push })
  end

  # Internal
  def init(gcm_config) do
    Logger.debug("PushIt.Client.GCM init: #{inspect(gcm_config)}")

    { :ok, gcm_config }
  end

  def handle_cast({:push, push }, gcm_config) do
    case Phoenix.HTTPClient.request(:post, gcm_config.url, %{}, push) do
      { :ok, gcm_response } -> PushIt.Client.GCMResponse.handle_response(gcm_response)
      { :error, msg }       -> Logger.error(msg)
    end

    { :noreply, gcm_config}
  end
end
