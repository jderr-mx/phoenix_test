defmodule PhoenixTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixTest.PubSub},
      # Start the Endpoint (http/https)
      PhoenixTestWeb.Endpoint
      # Start a worker by calling: PhoenixTest.Worker.start_link(arg)
      # {PhoenixTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
