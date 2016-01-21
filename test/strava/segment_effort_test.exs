defmodule StravaTest.SegmentEffort do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.SegmentEffort

  setup_all do
    HTTPoison.start
  end
  
  setup do
    use_cassette "segment_effort#269990681" do
      segment_effort = Strava.SegmentEffort.retrieve(269990681)
      {:ok, [segment_effort: segment_effort]}
    end
    
  end

  test "retrieve segment effort", %{segment_effort: segment_effort} do
    assert segment_effort != nil
  end

  test "should populate segment effort", %{segment_effort: segment_effort} do
    assert segment_effort.name == "Losantiville Ave. "
    assert segment_effort.elapsed_time == 181
  end
end