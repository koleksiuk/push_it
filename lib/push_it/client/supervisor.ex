defmodule PushIt.Client.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(PushIt.Client.GCM, [
        %PushIt.Client.GCMConfig { url: Application.get_env(:push_it_gcm, :url) }
      ]),
      worker(PushIt.Client.GCMResponse, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

