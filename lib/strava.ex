defmodule Strava do
  @moduledoc """
  Provides access to Strava’s V3 API.

  The Strava V3 API is a publicly available interface allowing developers access
  to the rich Strava dataset.
  """

  @doc """
  Gets the Strava API application's Client ID from `:strava` environment config
  or `STRAVA_CLIENT_ID` system environment variable.

  ## Example

      # config/config.exs
      config :strava, client_id: 1234

  """
  def client_id do
    Application.get_env(:strava, :client_id) || System.get_env("STRAVA_CLIENT_ID")
  end

  @doc """
  Gets the Strava API application's Client Secret from `:strava` environment
  config or `STRAVA_CLIENT_SECRET` system environment variable.

  ## Example

      # config/config.exs
      config :strava, client_secret: "<client_secret>"

  """
  def client_secret do
    Application.get_env(:strava, :client_secret) || System.get_env("STRAVA_CLIENT_SECRET")
  end

  @doc """
  Gets the Strava API application's Access Token from `:strava` environment
  config or `STRAVA_ACCESS_TOKEN` system environment variable.

  ## Example

      # config/config.exs
      config :strava, access_token: "<access_token>"

  """
  def access_token do
    Application.get_env(:strava, :access_token) || System.get_env("STRAVA_ACCESS_TOKEN")
  end

  @doc """
  Gets the Strava API application's Access Token from `:strava` environment
  config or `STRAVA_ACCESS_TOKEN` system environment variable.

  ## Example

      # config/config.exs
      config :strava, refresh_token: "<refresh_token>"

  """
  def refresh_token do
    Application.get_env(:strava, :refresh_token) || System.get_env("STRAVA_REFRESH_TOKEN")
  end

  @doc """
  Gets the Strava API application's Access Token from `:strava` environment
  config or `STRAVA_REDIRECT_URI` system environment variable.

  ## Example

      # config/config.exs
      config :strava, redirect_uri: "https://example.com/auth/callback"

  """
  def redirect_uri do
    Application.get_env(:strava, :redirect_uri) || System.get_env("STRAVA_REDIRECT_URI")
  end

  @doc """
  Timeout to establish a connection, in milliseconds. Default is 8,000ms.
  """
  def connect_timeout, do: Application.get_env(:strava, :connect_timeout, 8_000)

  @doc """
  Timeout used when receiving a connection. Default is 5,000ms.
  """
  def recv_timeout, do: Application.get_env(:strava, :recv_timeout, 5_000)
end
