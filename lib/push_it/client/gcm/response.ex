defmodule PushIt.Client.GCM.Response do
  require Logger
  use GenServer

  # External
  def start_link() do
    { :ok, _pid } = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def handle_response(http_response) do
    GenServer.cast(__MODULE__, { :handle_response, http_response.status_code, http_response.body })
  end

  # Internal
  def init(_) do
    { :ok, nil }
  end

  def handle_cast({:handle_response, status, body }, state) when status == 200 do
    { :ok, response } = JSON.decode(body)

    results = response["results"]

    case response["results"] do
      results when(is_list(results)) -> results |> Enum.map(fn(resp) -> log_response(resp) end)
      _ -> Logger.warn "GCM Error: Undefined response: #{inspect(results)}"
    end

    { :noreply, state }
  end

  def handle_cast({:handle_response, _status, _body }, state) do
    Logger.error "GCM Error"

    { :noreply, state }
  end

  defp log_response(single_push_response) do
    case single_push_response["error"] do
      nil -> Logger.debug(inspect(single_push_response))
      _   -> Logger.warn(inspect(single_push_response))
    end
  end
end
