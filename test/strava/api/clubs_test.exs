defmodule Strava.ClubsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "clubs" do
    test "#get_club_by_id" do
      use_cassette "clubs/get_club_by_id", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.DetailedClub{
           id: id,
           name: name,
           sport_type: sport_type,
           member_count: member_count
         }} = Strava.Clubs.get_club_by_id(client, 1)

        assert id == 1
        assert name == "Team Strava Cycling"
        assert sport_type == "cycling"
        assert is_number(member_count)
      end
    end

    test "#get_club_members_by_id" do
      use_cassette "clubs/get_club_members_by_id", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok, members} = Strava.Clubs.get_club_members_by_id(client, 1, per_page: 5, page: 1)

        assert length(members) == 5

        for member <- members do
          assert %Strava.SummaryAthlete{} = member
        end
      end
    end

    test "#get_club_activities_by_id" do
      use_cassette "clubs/get_club_activities_by_id", match_requests_on: [:query] do
        client = Strava.Client.new()
        club_id = club_id()

        {:ok, activities} =
          Strava.Clubs.get_club_activities_by_id(client, club_id, per_page: 10, page: 3)

        refute activities == []

        for activity <- activities do
          assert %Strava.SummaryActivity{} = activity
        end
      end
    end
  end

  defp club_id do
    Application.get_env(:strava, :test, [])[:club_id] || System.get_env("STRAVA_CLUB_ID")
  end
end
