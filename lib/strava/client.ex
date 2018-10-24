defmodule Strava.Client do
  @moduledoc """
  Handle Tesla connections for Strava.
  """

  use Tesla

  adapter(Tesla.Adapter.Hackney)

  plug(Tesla.Middleware.BaseUrl, "https://www.strava.com/api/v3")
  plug(Tesla.Middleware.Headers, [{"User-Agent", "https://hex.pm/packages/strava"}])
  plug(Tesla.Middleware.EncodeJson, engine: Poison)

  @doc """
  Configure a client connection using a provided OAuth2 token as a Bearer token

  ## Parameters

    - token (String) - Strava access token
    - opts (Keyword) - Optional params
      - `refresh_token` - Token used to refresh an expired access
        token.
      - `token_refreshed` - Single-arity callback function invoked
        whenever the access token is refreshed. Will be passed a `OAuth2.Client`
        containing the refreshed access token and refresh token.

  ## Returns

  `Tesla.Env.client`

  ## Examples

  Create a client with an access token:

      client = Strava.Client.new("<access_token>")

  Create a client with an optional refresh token, used to refresh an expired
  access token, and callback function invoked when the token is refreshed.

      client = Strava.Client.new("<access_token>",
        refresh_token: "<refresh_token>",
        token_refreshed: fn client -> IO.inspect(client, label: "client") end
      )

  """
  @spec new(String.t()) :: Tesla.Env.client()
  def new(access_token, opts \\ []) when is_binary(access_token) do
    Tesla.build_client([
      {Tesla.Middleware.Opts, request_opts()},
      {Strava.Middleware.AccessToken, access_token},
      {Strava.Middleware.RefreshToken, opts}
    ])
  end

  @doc """
  Configure a client using the default configured access token.

  # Returns

  Tesla.Env.client

  ## Example

      client = Strava.Client.new()

  """
  @spec new() :: Tesla.Env.client()
  def new do
    new(Strava.access_token(), refresh_token: Strava.refresh_token())
  end

  @doc false
  def set_authorization_header(%Tesla.Env{} = env, access_token) do
    %Tesla.Env{env | headers: [{"Authorization", "Bearer #{access_token}"}]}
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
