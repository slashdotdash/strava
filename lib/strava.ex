defmodule Strava do
  @moduledoc """
  Provides access to Strava’s V3 API.

  The Strava V3 API is a publicly available interface allowing developers access
  to the rich Strava dataset.

  More info: http://strava.github.io/api/
  """

  use HTTPoison.Base

  @endpoint "https://www.strava.com/api/v3/"
  @max_page_size 200
  @default_delay_between_requests_in_milliseconds 1_000

  @doc """
  Submit a request to the Strava API
  """
  def request(path, %Strava.Client{access_token: access_token}, opts \\ []) do
    path
    |> Strava.get!(%{"Authorization" => "Bearer #{access_token}"}, request_opts())
    |> parse(opts)
  end

  defp request_opts do
    [
      timeout: timeout(),
      recv_timeout: recv_timeout(),
    ]
  end

  defp parse(response, opts),
    do: Poison.decode!(response.body, opts ++ [keys: :atoms])

  defp process_url(path), do: @endpoint <> path

  @doc """
  Gets the Strava API Client ID from :strava, :client_id application
  env or STRAVA_CLIENT_ID from system ENV
  """
  def client_id do
    Application.get_env(:strava, :client_id) || System.get_env("STRAVA_CLIENT_ID")
  end

  @doc """
  Gets the Strava API Client Secret from :strava, :client_secret application env
  or STRAVA_CLIENT_SECRET from system ENV
  """
  def client_secret do
    Application.get_env(:strava, :client_secret) || System.get_env("STRAVA_CLIENT_SECRET")
  end

  @doc """
  Gets the Strava API access token from :strava, :access_token
  application env or STRAVA_ACCESS_TOKEN from system ENV Any registered Strava
  user can obtain an access_token by first creating an application at
  https://strava.com/developers
  """
  def access_token do
    Application.get_env(:strava, :access_token) || System.get_env("STRAVA_ACCESS_TOKEN")
  end

  def redirect_uri do
    Application.get_env(:strava, :redirect_uri) || System.get_env("STRAVA_REDIRECT_URI")
  end

  # Timeout to establish a connection, in milliseconds. Default is 8,000ms.
  defp timeout, do: Application.get_env(:strava, :timeout, 8_000)

  # Timeout used when receiving a connection. Default is 5,000ms.
  defp recv_timeout, do: Application.get_env(:strava, :recv_timeout, 5_000)

  def max_page_size, do: @max_page_size

  def delay_between_requests_in_milliseconds do
    Application.get_env(:strava, :delay_between_requests_in_milliseconds) ||
      @default_delay_between_requests_in_milliseconds
  end
end
