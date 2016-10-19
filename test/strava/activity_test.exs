defmodule Strava.ActivityTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Club

  setup_all do
    HTTPoison.start
  end

  test "retrieve club" do
    use_cassette "activity/retrieve#746805584" do
      activity = Strava.Activity.retrieve(746805584)

      assert activity != nil
      assert activity.name == "BTC run"
      assert activity.type == "Run"
    end
  end
end
