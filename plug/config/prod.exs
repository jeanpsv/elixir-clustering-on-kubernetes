use Mix.Config

config :elixir_clustering_on_kubernetes, :env, :prod

config :logger,
  level: :warn

config :peerage, via: Peerage.Via.Udp, serves: true
