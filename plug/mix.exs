defmodule ElixirClusteringOnKubernetes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_clustering_on_kubernetes,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirClusteringOnKubernetes.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.4"},
      {:plug, "~> 1.6"},
      {:distillery,  "~> 1.5"}
    ]
  end
end
