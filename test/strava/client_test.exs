defmodule Strava.ClientTest do
  use ExUnit.Case, async: false

  describe "refresh_token middleware" do
    test "retries the failed request" do
      access_token = "abcd1234" # invalid/expired access token

      client = Strava.Client.new(access_token, refresh_token: Strava.refresh_token())

      {:ok, %Strava.DetailedAthlete{}} = Strava.Athletes.get_logged_in_athlete(client)
    end
  end
end
