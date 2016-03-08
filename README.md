# Strava

Elixir wrapper for the [Strava API](https://strava.github.io/api/) (V3).

All calls to the Strava API require an `access_token` defining the athlete and application making the call. Any registered Strava user can obtain an `access_token` by first creating an application at [strava.com/developers](http://www.strava.com/developers).

## Installation

  1. Add strava to your list of dependencies in `mix.exs`:

        def deps do
          [{:strava, "~> 0.0.1"}]
        end

  2. Ensure strava is started before your application:

        def application do
          [applications: [:strava]]
        end

## Usage

Add the following `strava` configuration settings to each environment's mix config file.

Enter your Strava application settings as shown on https://www.strava.com/settings/api.

```elixir
# config/dev.exs
use Mix.Config

config :strava,
  client_id: <client id>,
  client_secret: "<client secret>",
  access_token: "<access token>",
  redirect_uri: "<redirect url>"
```

#### Clubs

```elixir
# retrieve a club
club = Strava.Club.retrieve(7289)
```

```elixir
# list club members
members = Strava.Club.list_members(7289, %{per_page: 20, page: 1})
```

```elixir
# stream club members
member_stream = Strava.Club.stream_members(7289)
|> Enum.to_list
```

#### Segments

```elixir
# retrieve a segment
segment = Strava.Segment.retrieve(229781)
```

```elixir
# list segment efforts
segment_efforts = Strava.Segment.list_efforts(229781)
```

```elixir
# list segment efforts, filtered by athlete
segment_efforts = Strava.Segment.list_efforts(229781, %{athlete_id: 5287})
```

```elixir
# list segment efforts, filtered by start and end dates
segment_efforts = Strava.Segment.list_efforts(229781, %{
  start_date_local: "2014-01-01T00:00:00Z",
  end_date_local: "2014-01-01T23:59:59Z"
})
```

```elixir
# stream segment efforts, filtered by start and end dates
segment_efforts = Strava.Segment.stream_efforts(229781, %{
  start_date_local: "2014-01-01T00:00:00Z",
  end_date_local: "2014-01-01T23:59:59Z"
})
|> Enum.to_list
```

#### Segment efforts

```elixir
# retrieve segment effort
segment_effort = Strava.SegmentEffort.retrieve(269990681)
```

## Testing

To run the entire test suite.

```
$ export STRAVA_ACCESS_TOKEN=<access token>
$ mix test
```
