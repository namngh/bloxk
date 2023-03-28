defmodule Bloxk.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Bloxk.Node,
      BloxkWeb.Telemetry,
      {Phoenix.PubSub, name: Bloxk.PubSub},
      BloxkWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Bloxk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BloxkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
