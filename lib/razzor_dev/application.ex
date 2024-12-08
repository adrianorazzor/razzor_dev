defmodule RazzorDev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RazzorDevWeb.Telemetry,
      RazzorDev.Repo,
      {DNSCluster, query: Application.get_env(:razzor_dev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RazzorDev.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RazzorDev.Finch},
      # Start a worker by calling: RazzorDev.Worker.start_link(arg)
      # {RazzorDev.Worker, arg},
      # Start to serve requests, typically the last entry
      RazzorDevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RazzorDev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RazzorDevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
