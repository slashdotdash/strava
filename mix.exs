defmodule Strava.Mixfile do
  use Mix.Project

  @version "0.5.0"

  def project do
    [
      app: :strava,
      version: @version,
      elixir: "~> 1.5",
      name: "Strava",
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      consolidate_protocols: Mix.env == :prod,
      source_url: "https://github.com/slashdotdash/strava",
   ]
  end

  def application do
    [
      extra_applications: [
        :logger,
      ]
    ]
  end

  defp description do
"""
Elixir wrapper for the Strava API (V3).
"""
  end

  defp deps do
    [
      {:credo, "~> 0.8", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev]},
      {:ex_doc, "~> 0.18", only: :dev},
      {:exvcr, "~> 0.9", only: :test},
      {:httpoison, "~> 0.13"},
      {:markdown, github: "devinus/markdown", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev},
      {:oauth2, "~> 0.9"},
      {:poison, "~> 3.1"},
    ]
  end

  defp docs do
    [
      main: "Strava",
      canonical: "http://hexdocs.pm/strava",
      source_ref: "v#{@version}",
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
