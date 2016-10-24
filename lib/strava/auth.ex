defmodule Strava.Auth do
  @moduledoc """
  An OAuth2 strategy for Strava.
  """
  use OAuth2.Strategy

  import Strava.Util, only: [struct_from_map: 2]

  def new do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: Strava.client_id,
      client_secret: Strava.client_secret,
      redirect_uri: Strava.redirect_uri,
      site: "https://www.strava.com",
      authorize_url: "https://www.strava.com/oauth/authorize",
      token_url: "https://www.strava.com/oauth/token"
    ])
  end

  @doc """
  Returns the authorize url based on the client configuration.

  - approval_prompt: string optional
    "force" or "auto", use "force" to always show the authorization prompt even if the user has already authorized the current application, default is "auto"

  - scope: string optional
    comma delimited string of "view_private" and/or "write", leave blank for read-only permissions.

  - state: string optional
    returned to your application, useful if the authentication is done from various points in an app
  """
  def authorize_url!(params \\ []) do
    new
    |> put_param(:response_type, "code")
    |> OAuth2.Client.authorize_url!(params)
  end

  @doc """
  Fetches an `OAuth2.AccessToken` struct by making a request to the token endpoint.

  Returns the `OAuth2.Client` struct loaded with the access token which can then
  be used to make authenticated requests to an OAuth2 provider's API.

  You can pass options to the underlying http library via `options` parameter
  """
  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new, params, headers)
  end

  @doc """
  Parse the detailed representation of the current athlete from the OAuth2 access token contained inside the client.
  """
  def get_athlete!(client)
  def get_athlete!(%OAuth2.Client{token: access_token}), do: get_athlete!(access_token)

  @doc """
  Parse the detailed representation of the current athlete from the OAuth2 access token.
  """
  def get_athlete!(access_token)
  def get_athlete!(%OAuth2.AccessToken{other_params: other_params}) do
    other_params["athlete"]
    |> struct_from_map(Strava.Athlete)
    |> Strava.Athlete.parse
  end

  # strategy callbacks

  @doc """
  The authorization URL endpoint of the provider.

  - `params` additional query parameters for the URL
  """
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  @doc """
  Retrieve an access token given the specified validation code.
  """
  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> put_param(:client_secret, client.client_secret)
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
