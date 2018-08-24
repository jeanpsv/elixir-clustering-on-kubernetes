# ElixirClusteringOnKubernetes

I will explain all steps to run an automatic Elixir cluster on Kubernetes

1. Creating Elixir application (with Plug)
2. Building Elixir release with Distillery
3. Adding the power of Docker!
4. Clustering Elixir application
5. Deploying on Kubernetes



### 1. Creating Elixir application (with Plug)

Run mix command to create application
```bash
mix new plug --app elixir_clustering_on_kubernetes --sup
```
