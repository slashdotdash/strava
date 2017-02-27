defmodule Strava.Mixfile do
  use Mix.Project

  def project do
    [app: :strava,
     version: "0.3.3",
     elixir: "~> 1.4",
     name: "Strava",
     description: description(),
     package: package(),
     source_url: "https://github.com/slashdotdash/strava",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [
      :logger,
      :httpoison,
      :oauth2,
      :poison,
      ]
    ]
  end

  defp description do
"""
Elixir wrapper for the Strava API (V3)
"""
  end

  defp deps do
    [
      {:credo, "~> 0.5", only: :dev},
      {:dialyxir, "~> 0.4", only: [:dev]},
      {:ex_doc, "~> 0.14", only: :dev},
      {:exvcr, "~> 0.8", only: :test},
      {:httpoison, "~> 0.10"},
      {:markdown, github: "devinus/markdown", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:oauth2, "~> 0.8"},
      {:poison, "~> 3.0"},
    ]
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Ben Smith"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/slashdotdash/strava",
              "Docs" => "https://hexdocs.pm/strava/"}
    ]
  end
end
