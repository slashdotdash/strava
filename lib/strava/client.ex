defmodule Strava.Client do
  @moduledoc """
  Handle Tesla connections for Strava.
  """

  use Tesla

  adapter(Tesla.Adapter.Hackney)

  # Add any middleware here (authentication)
  plug(Tesla.Middleware.BaseUrl, "https://www.strava.com/api/v3")
  plug(Tesla.Middleware.Headers, [{"User-Agent", "https://hex.pm/packages/strava"}])
  plug(Tesla.Middleware.EncodeJson, engine: Poison)

  @scopes [
    # Read public segments, public routes, public profile data, public posts, public events, club feeds, and leaderboards
    "read",
    # Read private routes, private segments, and private events for the user
    "read_all",
    # Read all profile information even if the user has set their profile visibility to Followers or Only You
    "profile:read_all",
    # Update the user's weight and Functional Threshold Power (FTP), and access to star or unstar segments on their behalf
    "profile:write",
    # Read the user's activity data for activities that are visible to Everyone and Followers, excluding privacy zone data
    "activity:read",
    # The same access as activity:read, plus privacy zone data and access to read the user's activities with visibility set to Only You
    "activity:read_all",
    # Access to create manual activities and uploads, and access to edit any activities that are visible to the app, based on activity read access level
    "activity:write"
  ]

  @doc """
  Configure a client connection using a provided OAuth2 token as a Bearer token

  ## Parameters

  - token (String): Bearer token

  ## Returns

  Tesla.Env.client
  """
  @spec new(String.t()) :: Tesla.Env.client()
  def new(access_token) when is_binary(access_token) do
    Tesla.build_client([
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{access_token}"}]},
      {Tesla.Middleware.Opts, request_opts()}
    ])
  end

  @doc """
  Configure a client connection using a function which yields a Bearer token.

  ## Parameters

  - token_fetcher (function arity of 1): Callback which provides an OAuth2 token
    given a list of scopes

  ## Returns

  Tesla.Env.client
  """
  @spec new((list(String.t()) -> String.t())) :: Tesla.Env.client()
  def new(token_fetcher) when is_function(token_fetcher) do
    token_fetcher.(@scopes) |> new()
  end

  @doc """
  Configure an authless client connection

  # Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client()
  def new do
    new(Strava.access_token())
  end

  defp request_opts do
    [
      adapter: [
        connect_timeout: Strava.connect_timeout(),
        recv_timeout: Strava.recv_timeout()
      ]
    ]
  end
end
