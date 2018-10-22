defmodule Strava.AthletesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "athletes" do
    test "#get_logged_in_athlete" do
      use_cassette "athletes/get_logged_in_athlete", match_requests_on: [:query] do
        client = Strava.Client.new()

        assert {:ok, %Strava.DetailedAthlete{} = athlete} =
                 Strava.Athletes.get_logged_in_athlete(client)

        refute is_nil(athlete)
        assert is_number(athlete.id)
        assert_present(athlete.firstname)
        assert_present(athlete.lastname)

        refute athlete.clubs == []
        assert [%Strava.SummaryClub{} = club | _] = athlete.clubs
        assert_present(club.name)
      end
    end

    test "#get_logged_in_athlete_zones" do
      use_cassette "athletes/get_logged_in_athlete_zones", match_requests_on: [:query] do
        client = Strava.Client.new()

        assert {:ok,
                %Strava.Zones{
                  heart_rate: %Strava.HeartRateZoneRanges{
                    zones: [%Strava.ZoneRange{} = hr_z1 | _]
                  },
                  power: %Strava.PowerZoneRanges{zones: [%Strava.ZoneRange{} = pwr_z1 | _]}
                } = zones} = Strava.Athletes.get_logged_in_athlete_zones(client)

        assert is_number(hr_z1.min)
        assert is_number(hr_z1.max)

        assert is_number(pwr_z1.min)
        assert is_number(pwr_z1.max)
      end
    end

    test "#get_stats" do
      use_cassette "athletes/get_stats", match_requests_on: [:query] do
        client = Strava.Client.new()
        athlete_id = authenticated_athlete_id()

        assert {:ok,
                %Strava.ActivityStats{
                  all_ride_totals: %Strava.ActivityTotal{},
                  all_run_totals: %Strava.ActivityTotal{},
                  all_swim_totals: %Strava.ActivityTotal{},
                  recent_ride_totals: %Strava.ActivityTotal{},
                  recent_swim_totals: %Strava.ActivityTotal{},
                  ytd_ride_totals: %Strava.ActivityTotal{},
                  ytd_run_totals: %Strava.ActivityTotal{},
                  ytd_swim_totals: %Strava.ActivityTotal{}
                } = stats} = Strava.Athletes.get_stats(client, athlete_id)

        assert is_number(stats.all_ride_totals.count)
        assert is_number(stats.biggest_climb_elevation_gain)
        assert is_number(stats.biggest_ride_distance)
      end
    end
  end

  defp authenticated_athlete_id do
    Application.get_env(:strava, :test, [])[:athlete_id] || System.get_env("STRAVA_ATHLETE_ID")
  end
end
