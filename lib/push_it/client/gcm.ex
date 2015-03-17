defmodule PushIt.Client.GCM do
  require Logger
  use GenServer

  # External
  def start_link(gcm_config \\ %PushIt.Client.GCM.Config{}) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, gcm_config, [])
  end

  def push(pid, push, api_key, handler \\ PushIt.Client.GCM.Request) do
    GenServer.cast(pid, {:push, push, api_key, handler})
  end

  # Internal
  def init(gcm_config) do
    Logger.debug("PushIt.Client.GCM init: #{inspect(gcm_config)}")

    { :ok, gcm_config }
  end

  def handle_cast({:push, push, api_key, handler }, gcm_config) do
    internal_push = %PushIt.Client.GCM.Push{
      struct: push,
      url: gcm_config.url,
      api_key: api_key
    }

    try do
      handler.perform(internal_push)
      |> PushIt.Client.GCM.Response.handle_response
    rescue
      e in HTTPotion.HTTPError -> Logger.error(inspect(e))
    end

    { :noreply, gcm_config}
  end
end
