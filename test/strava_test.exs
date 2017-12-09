defmodule StravaTest do
  use ExUnit.Case, async: false

  setup_all do
    HTTPoison.start()
  end

  test "has an access token" do
    assert Strava.access_token() !== nil
  end

  @tag :manual
  test "respects request `:timeout` configuration" do
    try do
      Application.put_env(:strava, :timeout, 1)

      Strava.request("athlete", Strava.Client.new())

      flunk "failed to timeout"
    rescue
      e in HTTPoison.Error ->
        assert e.reason == :connect_timeout
    after
      Application.delete_env(:strava, :timeout)
    end
  end

  @tag :manual
  test "respects request `:recv_timeout` configuration" do
    try do
      Application.put_env(:strava, :recv_timeout, 1)

      Strava.request("athlete", Strava.Client.new())

      flunk "failed to timeout"
    rescue
      e in HTTPoison.Error ->
        assert e.reason == :timeout
    after
      Application.delete_env(:strava, :recv_timeout)
    end
  end
end
