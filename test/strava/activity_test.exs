defmodule Strava.ActivityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  test "retrieve activity" do
    use_cassette "activity/retrieve#746805584" do
      activity = Strava.Activity.retrieve(746805584)

      assert activity != nil
      assert activity.name == "BTC run"
      assert activity.type == "Run"
      assert activity.start_date == ~N[2016-10-16 14:07:07]
      assert activity.start_date_local == ~N[2016-10-16 08:07:07]
    end
  end

  test "list athlete activities" do
    use_cassette "activity/list_athlete_activities#1" do
      activities = Strava.Activity.list_athlete_activities(%Strava.Pagination{per_page: 5, page: 1})

      assert length(activities) == 5
    end
  end

  test "list activities by page" do
    use_cassette "activity/list_athlete_activities#1.page#1", match_requests_on: [:query] do
      activities = Strava.Activity.list_athlete_activities(%Strava.Pagination{per_page: 200, page: 10})

      assert activities == []
    end
  end

  test "list activities before date" do
    use_cassette "activity/list_athlete_activities#1.before#1", match_requests_on: [:query] do
      activities = Strava.Activity.list_athlete_activities(%Strava.Pagination{per_page: 1, page: 1}, %{before: "2010-04-20T00:00:12Z"})

      assert activities == []
    end
  end
end
