# ElixirClusteringOnKubernetes

I will explain all steps to run an automatic Elixir cluster on Kubernetes

1. Creating Elixir application
2. Building Elixir release with Distillery
3. Adding the power of Docker!
4. Clustering Elixir application
5. Deploying on Kubernetes



### 1. Creating Elixir application

Run mix command to create application
```bash
mix new plug --app elixir_clustering_on_kubernetes --sup
```



### 2. Building Elixir release with Distillery

Add `distillery` lib to `mix.exs` in `deps` list:
```elixir
defp deps do
	[
		{:distillery, "~> 1.5"}
	]
end
```

After that, just run `mix deps.get`(to download new dependencies), `mix release.init`(to generate release configuration files) and `mix release`(to generate a release).



### 3. Adding the power of Docker!

See implemented `./Dockerfile` to learn the details. To help in development environment I've implemented a `docker-compose.yaml`
