defmodule ElixirClusteringOnKubernetesWeb.CallControllerTest do
  use ElixirClusteringOnKubernetesWeb.ConnCase

  describe "ping" do
    test "return 200 and message pong", %{conn: conn} do
      conn = get conn, call_path(conn, :ping)
      assert text_response(conn, 200) == "pong"
    end
  end
end
