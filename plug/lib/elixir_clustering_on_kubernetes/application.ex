defmodule ElixirClusteringOnKubernetes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Plug.Adapters.Cowboy2
  alias ElixirClusteringOnKubernetes.Call

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ElixirClusteringOnKubernetes.Worker.start_link(arg)
      # {ElixirClusteringOnKubernetes.Worker, arg},
      {Cowboy2, scheme: :http, plug: Call, options: [port: 4000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirClusteringOnKubernetes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
