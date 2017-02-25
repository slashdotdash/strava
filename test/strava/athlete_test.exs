defmodule Strava.AthleteTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Athlete

  setup_all do
    HTTPoison.start
  end

  test "retrieve current athlete" do
    use_cassette "athlete/retrieve_current" do
      athlete = Strava.Athlete.retrieve_current

      refute is_nil athlete
      assert athlete.firstname == "Kerry"
      assert athlete.lastname == "Buckley"
      assert athlete.city == "Ipswich"
      assert athlete.id == 5324239
    end
  end

  test "retrieve athlete by ID" do
    use_cassette "athlete/retrieve#5324239" do
      athlete = Strava.Athlete.retrieve 5324239

      refute is_nil athlete
      assert athlete.firstname == "Kerry"
      assert athlete.lastname == "Buckley"
      assert athlete.city == "Ipswich"
    end
  end
end
