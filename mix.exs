defmodule Strava.Mixfile do
  use Mix.Project

  @description """
    Elixir wrapper for the Strava API (V3)
  """

  def project do
    [app: :strava,
     version: "0.0.2",
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
      {:ex_doc, "~> 0.13", only: :dev},
      {:exvcr, "~> 0.8", only: :test},
      {:httpoison, "~> 0.9"},
      {:markdown, github: "devinus/markdown", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:oauth2, "~> 0.7"},
      {:poison, "~> 2.2"}
    ]
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Ben Smith"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/slashdotdash/strava",
              "Docs" => "https://github.com/slashdotdash/strava"}
    ]
  end
end
