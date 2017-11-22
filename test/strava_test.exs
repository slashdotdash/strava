defmodule StravaTest do
  use ExUnit.Case

  test "has an access token" do
    assert Strava.access_token() !== nil
  end
end
