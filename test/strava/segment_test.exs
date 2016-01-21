defmodule StravaTest.Segment do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Segment

  setup_all do
    HTTPoison.start
  end
  
  setup do
    use_cassette "segment#229781" do
      segment = Strava.Segment.retrieve(229781)
      {:ok, [segment: segment]}
    end
    
  end

  test "retrieve segment", %{segment: segment} do
    assert segment != nil
  end

  test "should populate segment", %{segment: segment} do
    assert segment.name == "Hawk Hill"
  end
end