defmodule StravaTest do
  use ExUnit.Case
  doctest Strava

  test "has an access token" do
    assert Strava.access_token !== nil
  end
end