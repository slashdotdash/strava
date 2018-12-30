# Strava

Elixir wrapper for the [Strava API](https://developers.strava.com/) (v3), generated from the official [Strava API Swagger definition](https://developers.strava.com/docs/#client-code) using the [OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator).

All calls to the Strava API require an `access_token` defining the athlete and application making the call. Any registered Strava user can create their own application at [developers.strava.com](https://developers.strava.com/).

---

[Changelog](CHANGELOG.md)

MIT License

[![Build Status](https://travis-ci.org/slashdotdash/strava.svg?branch=master)](https://travis-ci.org/slashdotdash/strava)

---

> This README and the following guides follow the `master` branch which may not be the currently published version.
> [Read docs for the latest published version of Strava on Hex](https://hexdocs.pm/strava/).

## Installation

  1. Add `strava` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:strava, "~> 1.0"}]
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

### Client

All requests to the Strava API require [authentication](https://developers.strava.com/docs/authentication/).

Create a client to make requests as your own application:

```elixir
client = Strava.Client.new()
```

Provide an athlete's `access_token` to make requests on behalf of an authenticated athlete:

```elixir
client = Strava.Client.new("<<access_token>>")
```

#### Refresh expired tokens

Access tokens expire six hours after they are created, so they must be refreshed in order for an application to continuing making authenticated requests on behalf of an athlete.

You can create a client with an optional refresh token, used to refresh an expired access token, and optional callback function invoked when the token is refreshed.

```elixir
client = Strava.Client.new("<access_token>",
  refresh_token: "<refresh_token>",
  token_refreshed: fn client -> IO.inspect(client, label: "client") end
)
```

Using the above client, whenever a "401 Unauthorized" HTTP response status code is returned from an API request an attempt will be made to refresh the token and retry the original request.

The `token_refreshed` callback function can be used to persist the refreshed `access_token` and `refresh_token` to be used for further requests for the athlete.

### Clubs

#### Get club by id

```elixir
{:ok, %Strava.DetailedClub{} = club} = Strava.Clubs.get_club_by_id(client, 1)
```

#### Get club members by id

```elixir
{:ok, members} = Strava.Clubs.get_club_members_by_id(client, 1, per_page: 20, page: 1)
```

### Segments

#### Get segment by id

```elixir
{:ok, %Strava.DetailedSegment{}} = Strava.Segments.get_segment_by_id(client, 229781)
```

### Segment efforts

#### Get efforts by segment id

```elixir
{:ok, segment_efforts} = Strava.SegmentEfforts.get_efforts_by_segment_id(client, 229781)
```

Returns segment efforts for the authenticated athlete only.

##### Get efforts by start and end dates

```elixir
{:ok, segment_efforts} = Strava.SegmentEfforts.get_efforts_by_segment_id(client, 229781,
  start_date_local: "2014-01-01T00:00:00Z",
  end_date_local: "2014-01-01T23:59:59Z"
})
```

Convert `DateTime` structs to an ISO 8601 formatted date time string using:

```elixir
DateTime.to_iso8601(start_date_local)
```

#### Get segment effort by id

```elixir
{:ok, %Strava.DetailedSegmentEffort{} = segment_effort} =
  Strava.SegmentEfforts.get_segment_effort_by_id(client, 269990681)
```

### Activities

#### Get activity by id

```elixir
{:ok, %Strava.DetailedActivity{} = activity} = Strava.Activities.get_activity_by_id(client, 746805584)
```

#### Get logged in athlete's activities

```elixir
{:ok, activities] = Strava.Activities.get_logged_in_athlete_activities(client, per_page: 50, page: 1)
```

#### Stream paginated requests

Any requests which take optional pagination params (`per_page` and `page`) can be converted to an Elixir `Stream` by using `Strava.Paginator.stream/2`.

The first argument is a function which is provided the current pagination params to make the request to the Strava API.

```elixir
stream =
  Strava.Paginator.stream(
    fn pagination ->
      Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id, pagination)
    end,
    per_page: 10
  )

segment_efforts = stream |> Stream.take(20) |> Enum.to_list()
```

A `Strava.Paginator.RequestError` error will be raised if the request returns an error tagged tuple.

### OAuth support

You can use Strava as an authentication provider with the OAuth2 strategy included in this library.

Use `Strava.Auth.authorize_url!/1` to generate the Strava URL to redirect unauthenticated users to. After the user has successfully authenticated with Strava you can use `Strava.Auth.get_token!` to access their summary details and unique access token required to make authenticated requests on behalf of the user.

Include the [access scopes](http://developers.strava.com/docs/authentication/#request-access) your application requires as a comma delimited string (e.g. `"activity:read_all,activity:write"`). Applications should request only the scopes required for the application to function normally.

An example Phoenix authentication controller is shown below:

```elixir
defmodule Example.AuthController do
  use Example.Web, :controller

  def index(conn, _params) do
    redirect(conn, external: Strava.Auth.authorize_url!(scope: "profile:read,activity:read"))
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/callback` and is the the callback URL that
  Strava will redirect the user back to with a `code` that will be used to
  request an access token. The access token will then be used to access
  protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    client = Strava.Auth.get_token!(code: code, grant_type: "authorization_code")
    athlete = Strava.Auth.get_athlete!(client)

    conn
    |> put_session(:current_athlete, athlete)
    |> put_session(:access_token, client.token.access_token)
    |> put_session(:refresh_token, client.token.refresh_token)
    |> redirect(to: "/")
  end
end
```

With the `access_token` tracked against the user's session you can make requests to the Strava API on their behalf. Use `Strava.Client.new(access_token)` to create a client to use with each request for that user.

#### Refresh expired access tokens

Access tokens expire six hours after they are created, so they must be refreshed in order for an application to continuing making authenticated requests on behalf of an athlete.

Use the refresh token returned from the initial token exchange to obtain a fresh access token.

```elixir
client = Strava.Auth.get_token!(grant_type: "refresh_token", refresh_token: "<refresh_token>")

access_token = client.token.access_token
refresh_token = client.token.refresh_token
```

Both the `access_token` and `refresh_token` tokens will need to be stored to ensure authenticated requests can be made and the token can be later refreshed after expiry.

## Testing

To run the entire test suite, create a file called `config/test.secret.exs` with the following:

```elixir
# config/test.secret.exs
use Mix.Config

config :strava,
  access_token: "<access_token>",
  test: [
    athlete_id: "<athlete_id>",
    club_id: "<club_id>",
    segment_id: "<segment_id>"
  ]
```

Replace the above placeholders with values appropriate for your own Strava application and athlete profile: your own athlete id; a club id you are a member of; and a segment you have made at least one attempt at.

To run the test suite:

```
$ mix test
```

## Contributing

Pull requests to contribute new or improved features, and extend documentation are most welcome.

Please follow the existing coding conventions, or refer to the Elixir style guide.

You should include unit tests to cover any changes.

### Contributors

- [Dave Shah](https://github.com/daveshah)
- [Eric Thomas](https://github.com/et)
- [Kerry Buckley](https://github.com/kerryb)
- [Mathieu Fosse](https://github.com/pointcom)
- [Paweł Koniarski](https://github.com/lewapkon)
- [Ross Kaffenberger](https://github.com/rossta)
