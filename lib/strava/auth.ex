defmodule Strava.Auth do
  @moduledoc """
  An OAuth2 strategy for Strava.
  """
  use OAuth2.Strategy

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
    approval_prompt: string optional
      "force" or "auto", use "force" to always show the authorization prompt even if the user has already authorized the current application, default is "auto"

    scope: string optional
      comma delimited string of "view_private" and/or "write", leave blank for read-only permissions.

    state: string optional
      returned to your application, useful if the authentication is done from various points in an app
  """
  def authorize_url!(params \\ []) do
    new
    |> put_param(:response_type, "code")
    |> OAuth2.Client.authorize_url!(params)
  end

  # you can pass options to the underlying http library via `options` parameter
  def get_token!(params \\ [], headers \\ [], options \\ []) do
    OAuth2.Client.get_token!(new, params, headers, options)
  end

  # strategy callbacks

  @doc """
  Builds the URL to the authorization endpoint.
  """
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  @doc """
  Builds the URL to token endpoint.
  """
  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
