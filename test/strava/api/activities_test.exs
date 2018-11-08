defmodule Strava.ActivitiesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "activities" do
    test "#get_logged_in_athlete_activities" do
      client = Strava.Client.new()

      {:ok, [%Strava.SummaryActivity{id: id, name: name, type: type}]} =
        get_logged_in_athlete_activities(client, per_page: 1)

      assert is_number(id)
      assert_present(name)
      assert_present(type)
    end

    test "#get_activity_by_id" do
      client = Strava.Client.new()

      {:ok, [%Strava.SummaryActivity{id: id}]} =
        get_logged_in_athlete_activities(client, per_page: 1)

      use_cassette "athletes/get_activity_by_id", match_requests_on: [:query] do
        {:ok, %Strava.DetailedActivity{id: ^id, name: name, type: type}} =
          Strava.Activities.get_activity_by_id(client, id, include_all_efforts: false)

        assert is_number(id)
        assert_present(name)
        assert_present(type)
      end
    end
  end

  defp get_logged_in_athlete_activities(client, opts) do
    use_cassette "athletes/get_logged_in_athlete_activities", match_requests_on: [:query] do
      Strava.Activities.get_logged_in_athlete_activities(client, opts)
    end
  end
end
