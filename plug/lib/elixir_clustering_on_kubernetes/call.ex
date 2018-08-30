defmodule ElixirClusteringOnKubernetes.Call do
  @moduledoc false
  import Plug.Conn

  def init([]), do: false

  def call(%Plug.Conn{} = conn, _params) do
    node_name =
      Node.list
      |> List.first
      |> Atom.to_string
    conn
    |> send_resp(200, node_name)
    |> halt
  end
end
