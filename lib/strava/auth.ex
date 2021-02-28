defmodule Strava.Auth do
  @moduledoc """
  An OAuth2 strategy for Strava.
  """
  use OAuth2.Strategy

  def new do
    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: Strava.client_id(),
      client_secret: Strava.client_secret(),
      redirect_uri: Strava.redirect_uri(),
      site: "https://www.strava.com",
      authorize_url: "https://www.strava.com/oauth/authorize",
      token_url: "https://www.strava.com/oauth/token"
    )
    |> OAuth2.Client.put_serializer("application/json", Poison)
  end

  @doc """
  Returns the authorize url based on the client configuration.

  - approval_prompt: string optional
    "force" or "auto", use "force" to always show the authorization prompt even
    if the user has already authorized the current application, default is "auto"

  - scope: string required

    Requested scopes, as a comma delimited string, e.g. "activity:read_all,activity:write".
    Applications should request only the scopes required for the application to function normally.

      - `read` - read public segments, public routes, public profile data,
        public posts, public events, club feeds, and leaderboards
      - `read_all` - read private routes, private segments, and private events
        for the user
      - `profile:read_all` - read all profile information even if the user has
        set their profile visibility to Followers or Only You
      - `profile:write` - update the user's weight and Functional Threshold
        Power (FTP), and access to star or unstar segments on their behalf
      - `activity:read` - read the user's activity data for activities that
        are visible to Everyone and Followers, excluding privacy zone data
      - `activity:read_all` - the same access as activity:read, plus privacy
        zone data and access to read the user's activities with visibility set
        to Only You
      - `activity:write` - access to create manual activities and uploads, and
        access to edit any activities that are visible to the app, based on
        activity read access level

  - state: string optional
    returned to your application, useful if the authentication is done from
    various points in an app

  """
  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(new(), params)
  end

  @doc """
  Fetches an `OAuth2.AccessToken` struct by making a request to the token endpoint.

  Returns the `OAuth2.Client` struct loaded with the access token which can then
  be used to make authenticated requests to an OAuth2 provider's API.

  You can pass options to the underlying http library via `options` parameter
  """
  def get_token(params \\ [], headers \\ []) do
    OAuth2.Client.get_token(new(), params, headers)
  end

  @doc """
  Fetches an `OAuth2.AccessToken` struct by making a request to the token endpoint.

  Returns the `OAuth2.Client` struct loaded with the access token which can then
  be used to make authenticated requests to an OAuth2 provider's API.

  You can pass options to the underlying http library via `options` parameter
  """
  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new(), params, headers)
  end

  @doc """
  Parse the detailed representation of the current athlete from the OAuth2
  client or access token.
  """
  def get_athlete!(client_or_access_token)

  def get_athlete!(%OAuth2.Client{token: %OAuth2.AccessToken{} = access_token}),
    do: get_athlete!(access_token)

  def get_athlete!(%OAuth2.AccessToken{other_params: %{"athlete" => athlete}}) do
    Strava.Deserializer.transform(athlete, %{:as => %Strava.DetailedAthlete{}})
  end

  # OAuth2 strategy callbacks

  @doc """
  The authorization URL endpoint of the provider.

  - `params` additional query parameters for the URL

  """
  def authorize_url(client, params) do
    client
    |> put_param(:response_type, "code")
    |> put_param(:client_id, client.client_id)
    |> put_param(:redirect_uri, client.redirect_uri)
    |> merge_params(params)
  end

  @doc """
  Retrieve an access token given the specified validation code.
  """
  def get_token(client, params, headers) do
    {code, params} = Keyword.pop(params, :code, client.params["code"])
    {grant_type, params} = Keyword.pop(params, :grant_type)

    client
    |> put_param(:code, code)
    |> put_param(:grant_type, grant_type)
    |> put_param(:client_id, client.client_id)
    |> put_param(:redirect_uri, client.redirect_uri)
    |> put_param(:client_secret, client.client_secret)
    |> merge_params(params)
    |> put_header("Accept", "application/json")
    |> put_headers(headers)
  end
end
