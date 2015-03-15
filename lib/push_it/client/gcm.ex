defmodule PushIt.Client.GCM do
  defstruct struct: nil, url: nil, api_key: ""

  require Logger
  use GenServer

  # External
  def start_link(gcm_config \\ %PushIt.Client.GCM.Config{}) do
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
    internal_push = %PushIt.Client.GCM.Push{ struct: push, url: gcm_config.url}

    try do
      PushIt.Client.GCM.Request.call(internal_push) |> PushIt.Client.GCM.Response.handle_response
    rescue
      e in HTTPotion.HTTPError -> e |> inspect |> Logger.error
    end

    { :noreply, gcm_config}
  end
end
