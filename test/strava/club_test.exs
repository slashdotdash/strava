defmodule Strava.ClubTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  test "retrieve club" do
    use_cassette "club/retrieve#1" do
      club = Strava.Club.retrieve(1)

      assert club != nil
      assert club.id == 1
      assert club.name == "Team Strava Cycling"
      assert club.member_count > 1
      assert club.sport_type == "cycling"
    end
  end

  test "list members" do
    use_cassette "club/list_members#1", match_requests_on: [:query] do
      members = Strava.Club.list_members(1, %Strava.Pagination{per_page: 5, page: 1})

      assert length(members) == 5
    end
  end

  test "list members by page" do
    use_cassette "club/list_members#1.page#3", match_requests_on: [:query] do
      members = Strava.Club.list_members(1, %Strava.Pagination{per_page: 200, page: 3})

      assert members == []
    end
  end

  test "stream members" do
    use_cassette "club/stream_members#1", match_requests_on: [:query]  do
      member_stream = Strava.Club.stream_members(1)

      assert Enum.count(member_stream) > 1
    end
  end

  test "list activities by page" do
    use_cassette "club/list_activities#299657", match_requests_on: [:query]  do
      activities = Strava.Club.list_activities(299657, %Strava.Pagination{per_page: 10, page: 3})

      assert Enum.count(activities) == 10
    end
  end
end
