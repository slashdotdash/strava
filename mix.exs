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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger],
     mod: {Strava, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [{:httpoison, "~> 0.8.1"}]
  end
end
