defmodule ElixirClusteringOnKubernetesTest do
  use ExUnit.Case
  doctest ElixirClusteringOnKubernetes

  test "greets the world" do
    assert ElixirClusteringOnKubernetes.hello() == :world
  end
end
