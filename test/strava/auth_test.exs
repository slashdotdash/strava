defmodule Strava.AuthTest do
  use ExUnit.Case, async: false

  # Manual test to verify token exchange, provide a valid code to run
  @tag :manual
  test "get token from code" do
    token = Strava.Auth.get_token!(code: "<<code>>")

    assert %Strava.DetailedAthlete{} = Strava.Auth.get_athlete!(token)
  end

  test "get athlete from access token" do
    assert %Strava.DetailedAthlete{id: id, firstname: firstname, lastname: lastname, sex: sex} =
             Strava.Auth.get_athlete!(access_token())

    assert id == 227_615
    assert firstname == "John"
    assert lastname == "Applestrava"
    assert sex == "M"
  end

  # Example token response taken from Strava's API docs
  # http://strava.github.io/api/v3/oauth/
  defp access_token do
    OAuth2.AccessToken.new(%{
      "access_token" => "83ebeabdec09f6670863766f792ead24d61fe3f9",
      "athlete" => %{
        "id" => 227_615,
        "resource_state" => 3,
        "firstname" => "John",
        "lastname" => "Applestrava",
        "profile_medium" => "http://pics.com/227615/medium.jpg",
        "profile" => "http://pics.com/227615/large.jpg",
        "city" => "San Francisco",
        "state" => "California",
        "country" => "United States",
        "sex" => "M",
        "friend" => nil,
        "follower" => nil,
        "premium" => true,
        "email" => "john@applestrava.com",
        "created_at" => "2008-01-01T17:44:00Z",
        "updated_at" => "2013-09-04T20:00:50Z"
      }
    })
  end
end
