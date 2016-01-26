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
      assert club.member_count == 193
      assert club.sport_type == "cycling"
      assert club.member_count == 193
    end
  end

  test "list members" do
    use_cassette "club/list_members#7289" do
      members = Strava.Club.list_members(7289, %{per_page: 5})

      assert members != nil
      assert length(members) == 5
    end
  end
end