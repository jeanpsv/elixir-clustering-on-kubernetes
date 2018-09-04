defmodule ElixirClusteringOnKubernetes do
  @moduledoc """
  Documentation for ElixirClusteringOnKubernetes.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirClusteringOnKubernetes.hello
      :world

  """
  def hello do
    :world
  end

   def call do
     Node.self
   end
end
