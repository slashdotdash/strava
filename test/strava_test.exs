defmodule StravaTest do
  use ExUnit.Case
  doctest Strava

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "has an access token" do
    assert Strava.access_token !== nil
  end

  test "retrieve segment" do
    Strava.Segment.retrieve 229781
  end
end