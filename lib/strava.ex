defmodule Strava do
  use HTTPoison.Base

  @endpoint "https://www.strava.com/api/v3/"
  @max_page_size 200

  @doc """
  Submit a request to the Strava API
  """
  def request(path, opts \\ []) do
    Strava.get!(path)
    |> parse(opts)
  end

  defp parse(response, opts) do
    Poison.decode!(response.body, opts)
  end

  defp process_url(path) do
    @endpoint <> path
  end

  defp process_request_headers(headers) do
    Dict.put headers, :Authorization, "Bearer #{access_token}"
  end

  @doc """
  Gets the Strava API Client ID from :strava, :client_id application env or STRAVA_CLIENT_ID from system ENV
  """
  def client_id do
    Application.get_env(:strava, :client_id) || System.get_env("STRAVA_CLIENT_ID")    
  end
  
  @doc """
  Gets the Strava API Client Secret from :strava, :client_secret application env or STRAVA_CLIENT_SECRET from system ENV
  """
  def client_secret do
    Application.get_env(:strava, :client_secret) || System.get_env("STRAVA_CLIENT_SECRET")    
  end

  @doc """
  Gets the Strava API access token from :strava, :access_token application env or STRAVA_ACCESS_TOKEN from system ENV
  Any registered Strava user can obtain an access_token by first creating an application at https://strava.com/developers
  """
  def access_token do
    Application.get_env(:strava, :access_token) || System.get_env("STRAVA_ACCESS_TOKEN")
  end

  def redirect_uri do
    Application.get_env(:strava, :redirect_uri) || System.get_env("STRAVA_REDIRECT_URI")
  end

  def max_page_size do
    @max_page_size
  end
end