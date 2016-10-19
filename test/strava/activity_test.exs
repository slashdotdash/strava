defmodule Strava.ActivityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Activity

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
end
