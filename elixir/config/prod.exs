use Mix.Config

config :elixir_clustering_on_kubernetes, :env, :prod

config :logger,
  level: :warn

# docker-compose.yaml configuration
# config :peerage, via: Peerage.Via.Udp, serves: true

# kubernetes configuration
config :peerage, via: Peerage.Via.Dns,
  dns_name: "myapp-headless-service.${NAMESPACE}.svc.cluster.local",
  app_name: "myapp",
  interval: 5
