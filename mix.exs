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
     package: package,
     source_url: "https://github.com/slashdotdash/strava",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [
      :logger, 
      :httpoison,
      :oauth2
      ]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.1"},
      {:oauth2, "~> 0.5.0"},    
      {:poison, "~> 2.0", override: true},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end

  defp package do
    [
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Ben Smith"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/slashdotdash/strava",
              "Docs" => "https://github.com/slashdotdash/strava"}
    ]
  end
end
