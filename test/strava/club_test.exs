defmodule Strava.ClubTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Club

  setup_all do
    HTTPoison.start
  end

  test "retrieve club" do
    use_cassette "club/retrieve#7289" do
      club = Strava.Club.retrieve(7289)

      assert club != nil
      assert club.name == "VC Venta"
      assert club.member_count > 1
      assert club.sport_type == "cycling"
    end
  end

  test "list members" do
    use_cassette "club/list_members#7289" do
      members = Strava.Club.list_members(7289, %{per_page: 5, page: 1})

      assert length(members) == 5
    end
  end

  test "list members by page" do
    use_cassette "club/list_members#7289.page#3" do
      members = Strava.Club.list_members(7289, %{per_page: 200, page: 3})

      assert members == []
    end
  end

  test "stream members" do
    use_cassette "club/stream_members#7289", match_requests_on: [:query]  do
      member_stream = Strava.Club.stream_members(7289)

      assert Enum.count(member_stream) > 1
    end
  end
end
