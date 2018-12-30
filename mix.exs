defmodule Strava.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :strava,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Strava",
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() == :prod,
      source_url: "https://github.com/slashdotdash/strava"
    ]
  end

  def application do
    [
      extra_applications: [
        :logger
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
      {:hackney, ">= 0.0.0"},
      {:oauth2, "~> 0.9"},
      {:poison, "~> 3.1 or ~> 4.0"},
      {:tesla, "~> 1.2"},

      # Build & test tools
      {:credo, "~> 1.0", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev},
      {:exvcr, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 0.9", only: :dev}
    ]
  end

  defp docs do
    [
      main: "Strava",
      canonical: "http://hexdocs.pm/strava",
      source_ref: "v#{@version}"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Ben Smith"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/slashdotdash/strava",
        "Docs" => "https://hexdocs.pm/strava/"
      }
    ]
  end
end
