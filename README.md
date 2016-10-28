# Strava

Elixir wrapper for the [Strava API](https://strava.github.io/api/) (V3).

All calls to the Strava API require an `access_token` defining the athlete and application making the call. Any registered Strava user can obtain an `access_token` by first creating an application at [strava.com/developers](http://www.strava.com/developers).

MIT License

[![Build Status](https://travis-ci.org/slashdotdash/strava.svg?branch=master)](https://travis-ci.org/slashdotdash/strava)

## Installation

  1. Add `strava` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:strava, "~> 0.1"}]
  end
  ```

  2. Ensure `strava` is included in your applications:

  ```elixir
  def application do
    [applications: [:strava]]
  end
  ```

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

### Clubs

#### Retrieve a club

```elixir
club = Strava.Club.retrieve(7289)
```

#### List club members

```elixir
members = Strava.Club.list_members(7289, %Strava.Pagination{per_page: 20, page: 1})
```

#### Stream club members

```elixir
member_stream = Strava.Club.stream_members(7289)
|> Enum.to_list
```

### Segments

#### Retrieve a segment

```elixir
segment = Strava.Segment.retrieve(229781)
```

#### List segment efforts

```elixir
segment_efforts = Strava.Segment.list_efforts(229781)
```

#### List segment efforts filtered by athlete

```elixir
segment_efforts = Strava.Segment.list_efforts(229781, %{athlete_id: 5287})
```

#### List segment efforts filtered by start and end dates

```elixir
segment_efforts = Strava.Segment.list_efforts(229781, %{
  start_date_local: "2014-01-01T00:00:00Z",
  end_date_local: "2014-01-01T23:59:59Z"
})
```

#### Stream segment efforts filtered by start and end dates

```elixir
segment_efforts = Strava.Segment.stream_efforts(229781, %{
  start_date_local: "2014-01-01T00:00:00Z",
  end_date_local: "2014-01-01T23:59:59Z"
})
|> Enum.to_list
```

### Segment efforts

#### Retrieve segment effort

```elixir
segment_effort = Strava.SegmentEffort.retrieve(269990681)
```

### Activities

#### Retrieve an activity

```elixir
activity = Strava.Activity.retrieve(746805584)
```

## Testing

To run the entire test suite, create a file called `config/test.secret.exs` with the following:

```elixir
# config/test.secret.exs
use Mix.Config

config :strava,
  access_token: "<access token>"
```

and run:

```
$ mix test
```

## Contributing

Pull requests to contribute new or improved features, and extend documentation are most welcome.

Please follow the existing coding conventions, or refer to the Elixir style guide.

You should include unit tests to cover any changes.

### Contributors

- [Eric Thomas](https://github.com/et)
