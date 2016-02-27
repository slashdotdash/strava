# Strava

Elixir wrapper for the [Strava API](https://strava.github.io/api/) (V3).

## Installation

  1. Add strava to your list of dependencies in `mix.exs`:

        def deps do
          [{:strava, "~> 0.0.1"}]
        end

  2. Ensure strava is started before your application:

        def application do
          [applications: [:strava]]
        end

