# Strava

Elixir wrapper for the [Strava API](https://strava.github.io/api/) (V3).

All calls to the Strava API require an `access_token` defining the athlete and application making the call. Any registered Strava user can obtain an `access_token` by first creating an application at [strava.com/developers](http://www.strava.com/developers).

MIT License

[![Build Status](https://travis-ci.org/slashdotdash/strava.svg?branch=master)](https://travis-ci.org/slashdotdash/strava)

## Installation

  1. Add `strava` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:strava, "~> 0.3"}]
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

#### List club members

```elixir
members = Strava.Club.list_members(7289, %Strava.Pagination{per_page: 20, page: 1})
```

#### Stream club members

```elixir
member_stream = Strava.Club.stream_members(7289)
member_list = member_stream |> Enum.to_list
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

#### List activities for current authenticated athlete

```elixir
activities = Strava.Activity.list_athlete_activities(Strava.Pagination{per_page: 50, page: 1})
```

#### List activities for current authenticated athlete after a given datetime

```elixir
activities = Strava.Activity.list_athlete_activities(Strava.Pagination{per_page: 50, page: 1}. %{after: "2017-04-20T00:00:12Z"})
```

### Client

The Strava API allows an application to make requests on the  behalf of an authenticated user by using an `access_token` unique to that user.

Each of the above API functions supports providing an `Strava.Client` with a configured access token.

```elixir
client = Strava.Client.new("<access_token>")
club = Strava.Club.retrieve(1, client)
```

### OAuth support

You can use Strava as an authentication provider with the OAuth2 strategy provided. Use `Strava.Auth.authorize_url!/1` to generate the Strava URL to redirect unauthenticated users to.

After the user has successfully authenticated with Strava you can use `Strava.Auth.get_token!` to access their summary details and unique access token.

An example Phoenix authentication controller is shown below:

```elixir
defmodule Example.AuthController do
  use Example.Web, :controller

  def index(conn, _params) do
    redirect conn, external: Strava.Auth.authorize_url!(scope: "public")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/callback` and is the the callback URL that Strava will redirect the user back to with a `code` that will be used to request an access token.
  The access token will then be used to access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    client = Strava.Auth.get_token!(code: code)
    athlete = Strava.Auth.get_athlete!(client)

    conn
      |> put_session(:current_athlete, athlete)
      |> put_session(:access_token, client.token.access_token)
      |> redirect(to: "/")
  end
end
```

With the `access_token` tracked against the user's session you can make requests to the Strava API on their behalf. Use `Strava.Client.new(access_token)` to create a client to use with each request for that user.

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
- [Kerry Buckley](https://github.com/kerryb)
- [Paweł Koniarski](https://github.com/lewapkon)
- [Ross Kaffenberger](https://github.com/rossta)
