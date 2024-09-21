defmodule Puzzlars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PuzzlarsWeb.Telemetry,
      Puzzlars.Repo,
      {DNSCluster, query: Application.get_env(:puzzlars, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Puzzlars.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Puzzlars.Finch},
      # Start a worker by calling: Puzzlars.Worker.start_link(arg)
      # {Puzzlars.Worker, arg},
      # Start to serve requests, typically the last entry
      PuzzlarsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Puzzlars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PuzzlarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
