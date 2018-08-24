defmodule ElixirClusteringOnKubernetesWeb.Router do
  use ElixirClusteringOnKubernetesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirClusteringOnKubernetesWeb do
    pipe_through :api

    get "/ping", CallController, :ping
  end
end
