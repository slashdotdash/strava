defmodule StravaTest.Segment do
  use ExUnit.Case
  doctest Strava.Segment

  setup do
    segment = Strava.Segment.retrieve(229781)
    IO.inspect segment
    {:ok, [segment: segment]}
  end

  test "retrieve segment", %{segment: segment} do
    assert segment !== nil
  end
end