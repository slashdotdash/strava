defmodule Strava.AthletesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "athletes" do
    test "#get_logged_in_athlete" do
      use_cassette "athletes/get_logged_in_athlete", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.DetailedAthlete{id: id, firstname: firstname, lastname: lastname, clubs: clubs}} =
          Strava.Athletes.get_logged_in_athlete(client)

        assert is_number(id)
        assert_present(firstname)
        assert_present(lastname)

        refute clubs == []

        for club <- clubs do
          %Strava.SummaryClub{id: id, name: name} = club

          assert is_number(id)
          assert_present(name)
        end
      end
    end

    test "#get_logged_in_athlete_zones" do
      use_cassette "athletes/get_logged_in_athlete_zones", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.Zones{
           heart_rate: %Strava.HeartRateZoneRanges{zones: heart_rate_zones},
           power: %Strava.PowerZoneRanges{zones: power_zones}
         }} = Strava.Athletes.get_logged_in_athlete_zones(client)

        refute heart_rate_zones == []

        for zone <- heart_rate_zones do
          %Strava.ZoneRange{min: min, max: max} = zone

          assert is_number(min)
          assert is_number(max)
        end

        refute power_zones == []

        for zone <- power_zones do
          %Strava.ZoneRange{min: min, max: max} = zone

          assert is_number(min)
          assert is_number(max)
        end
      end
    end

    test "#get_stats" do
      use_cassette "athletes/get_stats", match_requests_on: [:query] do
        client = Strava.Client.new()
        athlete_id = authenticated_athlete_id()

        {:ok,
         %Strava.ActivityStats{
           all_ride_totals: %Strava.ActivityTotal{},
           all_run_totals: %Strava.ActivityTotal{},
           all_swim_totals: %Strava.ActivityTotal{},
           recent_ride_totals: %Strava.ActivityTotal{},
           recent_swim_totals: %Strava.ActivityTotal{},
           ytd_ride_totals: %Strava.ActivityTotal{},
           ytd_run_totals: %Strava.ActivityTotal{},
           ytd_swim_totals: %Strava.ActivityTotal{},
           biggest_climb_elevation_gain: biggest_climb_elevation_gain,
           biggest_ride_distance: biggest_ride_distance
         } = stats} = Strava.Athletes.get_stats(client, athlete_id)

        assert is_number(stats.all_ride_totals.count)
        assert is_number(biggest_climb_elevation_gain)
        assert is_number(biggest_ride_distance)
      end
    end
  end

  defp authenticated_athlete_id do
    Application.get_env(:strava, :test, [])[:athlete_id] || System.get_env("STRAVA_ATHLETE_ID")
  end
end
