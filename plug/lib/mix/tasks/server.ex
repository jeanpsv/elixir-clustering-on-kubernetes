defmodule Mix.Tasks.Server do
  @shortdoc "Starts the application and their servers"
  @moduledoc """
  This module is responsible to load the application.
  """

  use Mix.Task
  alias Mix.Tasks.Run
  require Logger

  def run(args) do
    Logger.info "Running ElixirClusteringOnKubernetes application"
    Run.run run_args() ++ args
  end

  defp run_args do
    if iex_running?(), do: [], else: ["--no-halt"]
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?
  end
end
