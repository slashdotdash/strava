defmodule Strava.RequestTest do
  use ExUnit.Case, async: false

  test "has an access token" do
    refute is_nil(Strava.access_token())
  end

  @tag :manual
  test "respects request `:timeout` configuration" do
    try do
      Application.put_env(:strava, :connect_timeout, 1)

      assert {:error, :connect_timeout} = make_request()
    after
      Application.delete_env(:strava, :connect_timeout)
    end
  end

  @tag :manual
  test "respects request `:recv_timeout` configuration" do
    try do
      Application.put_env(:strava, :recv_timeout, 1)

      assert {:error, :timeout} = make_request()
    after
      Application.delete_env(:strava, :recv_timeout)
    end
  end

  defp make_request do
    client = Strava.Client.new()

    Strava.Client.request(client,
      method: :get,
      url: "https://www.strava.com/api/v3/athlete"
    )
  end
end
