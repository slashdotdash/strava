defmodule Strava.Mixfile do
  use Mix.Project

  @description """
    Elixir wrapper for the Strava API (V3)
  """

  def project do
    [app: :strava,
     version: "0.0.1",
     elixir: "~> 1.2",
     name: "Strava",
     description: @description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison, :exjsx],
     mod: {Strava, []}]
  end

  defp deps do
    [{:httpoison, "~> 0.8.1"},
     { :exjsx, "~> 3.2.0", app: false }]
    # {:exvcr, "~> 0.7", only: :test}
  end
end
