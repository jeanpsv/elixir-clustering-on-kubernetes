# ElixirClusteringOnKubernetes

I will explain all steps to run an automatic Elixir cluster on Kubernetes

1. Creating Elixir application (with Phoenix)
2. Building Elixir release with Distillery
3. Adding the powerful of Docker!
4. Clustering Elixir application
5. Deploying on Kubernetes



### 1. Creating Elixir application (with Phoenix)

Run mix command to create application
```bash
mix phx.new elixir-clustering-on-kubernetes --app elixir_clustering_on_kubernetes --no-brunch --no-html --no-ecto
```



### 2. Building Elixir release with Distillery

Add `distillery` lib to `mix.exs` in `deps` list:
```elixir
defp deps do
    [
        {:phoenix, "~> 1.3.4"},
        {:phoenix_pubsub, "~> 1.0"},
        {:gettext, "~> 0.11"},
        {:cowboy, "~> 1.0"},
        {:distillery, "~> 1.5"}
    ]
end
```

After that, just run `mix deps.get`(to download new dependencies), `mix release.init`(to generate release configuration files) and `mix release`(to generate a release).

Update `config/prod.exs` to use environment variables instead hardcoded ones. This improvement allow us to use the same release configuration for many environments
```elixir
config :elixir_clustering_on_kubernetes, ElixirClusteringOnKubernetesWeb.Endpoint,
  load_from_system_env: false,
  http: [port: "${PORT}"],
  url: [host: "${HOST}", port: "${PORT}"],
  secret_key_base: "${SECRET_KEY_BASE}",
  server: true
```

and remove the last line `import_config "prod.secret.exs"`, this is unnecessary now.



### 3. Adding the powerful of Docker!

See implemented `./Dockerfile` to learn the details. To help in development environment I've implemented a `docker-compose.yaml`

```yaml
version: "3"

services:
  myapp1:
    build: .
    command: ["foreground"]
    environment:
      - PORT=4000
      - HOST=example.com
      - SECRET_KEY_BASE=my_super_secret_key_base
```

That file allow you to run `docker-compose up` to build image and run the application easily.

tips: use `docker-compose up -d` to detache after application starts running and `docker-compose down` to stop it.



### 4. Clustering Elixir application

Add `peerage` lib to `mix.exs` in `deps` list:
```elixir
defp deps do
    [
        {:phoenix, "~> 1.3.4"},
        {:phoenix_pubsub, "~> 1.0"},
        {:gettext, "~> 0.11"},
        {:cowboy, "~> 1.0"},
        {:distillery, "~> 1.5"},
        {:peerage, "~> 1.0"}
    ]
end
```

This lib is responsible to automatic cluster all the elixir application nodes, but a simple configuration is needed

Add the following line to `config/prod.exs`
```elixir
config :peerage, via: Peerage.Via.Udp, serves: true
```

this configuration (Peerage.Via.Udp) works when the elixir nodes are in the same network. Each node needs a ip address, so just update `docker-compose.yaml` adding a network
```yaml
networks:
  app_network:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.16.238.0/24
```
and allocation an ip address to each one:
```yaml
myapp1:
build: .
command: ["foreground"]
environment:
  - PORT=4000
  - HOST=example.com
  - SECRET_KEY_BASE=my_super_secret_key_base
  - APP_IP_ADDRESS=172.16.238.10
networks:
  app_network:
    ipv4_address: 172.16.238.10
```

now run `docker-compose up -d` and `docker exec -it elixir-clustering-on-kubernetes_myapp1_1 _build/prod/rel/elixir_clustering_on_kubernetes/bin/elixir_clustering_on_kubernetes remote_console` to access one node.
Now, on Elixir console run:
```elixir
iex> Node.list
```
to see list of other connected nodes.
