defmodule ElixirClusteringOnKubernetesWeb.CallController do
  use ElixirClusteringOnKubernetesWeb, :controller

  def ping(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(:ok, "pong")
  end
end
