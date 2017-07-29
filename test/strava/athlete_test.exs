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
      athlete = Strava.Athlete.retrieve(5324239)

      refute is_nil athlete
      assert athlete.firstname == "Kerry"
      assert athlete.lastname == "Buckley"
      assert athlete.city == "Ipswich"
    end
  end

  test "retrieve another athlete by ID" do
    use_cassette "athlete/retrieve#227615" do
      athlete = Strava.Athlete.retrieve(227615)

      refute is_nil athlete
      assert athlete.firstname == "Emily"
      assert athlete.lastname == "Parker"
      assert athlete.city == "San Francisco"
      assert athlete.country == "United States"
    end
  end

  test "retrieve athlete stats" do
    use_cassette "athlete/stats#5324239" do
      stats = Strava.Athlete.stats(5324239)

      refute is_nil stats
      assert_in_delta stats.biggest_ride_distance, 50988.8, 0.1
      assert_in_delta stats.biggest_climb_elevation_gain, 105.8, 0.1

      assert stats.recent_ride_totals.achievement_count == 4
      assert stats.recent_ride_totals.count == 62
      assert_in_delta stats.recent_ride_totals.distance, 353002.1, 0.1
      assert stats.recent_ride_totals.elapsed_time == 121101
      assert_in_delta stats.recent_ride_totals.elevation_gain, 828.9, 0.1
      assert stats.recent_ride_totals.moving_time == 65167

      assert_in_delta stats.recent_run_totals.distance, 137554.7, 0.1
      assert_in_delta stats.recent_swim_totals.distance, 0.0, 0.1

      assert stats.ytd_ride_totals.count == 125
      assert stats.ytd_ride_totals.distance == 745028
      assert stats.ytd_ride_totals.elapsed_time == 238632
      assert stats.ytd_ride_totals.elevation_gain == 1572
      assert stats.ytd_ride_totals.moving_time == 136875

      assert stats.ytd_run_totals.distance == 250465
      assert stats.ytd_swim_totals.distance == 0

      assert stats.all_run_totals.distance == 1869273
      assert stats.all_swim_totals.distance == 0
    end
  end

  test "retrieve an athlete's friends" do
    use_cassette "athlete/friends#5324239" do
      friends = Strava.Athlete.friends "5324239"

      refute is_nil friends
      assert length(friends) == 115
      friend = friends |> List.first
      assert friend.firstname == "Ben"
      assert friend.lastname == "Paddock"
    end
  end

  test "retrieve an athlete's followers" do
    use_cassette "athlete/followers#5324239" do
      followers = Strava.Athlete.followers "5324239"

      refute is_nil followers
      assert length(followers) == 109
      follower = followers |> List.first
      assert follower.firstname == "Abigail"
      assert follower.lastname == "Canham"
    end
  end
end
