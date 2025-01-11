defmodule Sveltly.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Cachex, name: :featured_raffles_cache},
      {NodeJS.Supervisor, [path: LiveSvelte.SSR.NodeJS.server_path(), pool_size: 4]},
      SveltlyWeb.Telemetry,
      Sveltly.Repo,
      {DNSCluster, query: Application.get_env(:sveltly, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Sveltly.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Sveltly.Finch},
      # Start a worker by calling: Sveltly.Worker.start_link(arg)
      # {Sveltly.Worker, arg},
      # Start to serve requests, typically the last entry
      SveltlyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sveltly.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SveltlyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
