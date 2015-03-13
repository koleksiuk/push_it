defmodule PushIt.Client.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    gcm_pool_count = Application.get_env(:push_it_gcm, :pool_count, 5)

    pool_options = [
      name:          { :local, :gcm_client },
      worker_module: PushIt.Client.GCM,
      size:          gcm_pool_count,
      max_overflow:  gcm_pool_count * 2
    ]

    children = [
      :poolboy.child_spec(:gcm_client, pool_options,
        %PushIt.Client.GCMConfig { url: Application.get_env(:push_it_gcm, :url) }
      ),
      worker(PushIt.Client.GCMResponse, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

