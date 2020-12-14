defmodule OfertasCurso.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      # Start the Telemetry supervisor
      OfertasCursoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OfertasCurso.PubSub},
      # Start the Endpoint (http/https)
      OfertasCursoWeb.Endpoint,
      worker(Mongo, [[name: :mongo, url: "mongodb://localhost:27017/offers", pool_size: 10]])
      # Start a worker by calling: OfertasCurso.Worker.start_link(arg)
      # {OfertasCurso.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OfertasCurso.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OfertasCursoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
