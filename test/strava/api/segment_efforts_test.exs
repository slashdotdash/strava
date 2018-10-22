defmodule Strava.SegmentEffortsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "segment efforts" do
    test "#get_efforts_by_segment_id" do
      assert {:ok, segment_efforts} = get_efforts_by_segment_id()

      for segment_effort <- segment_efforts do
        assert %Strava.DetailedSegmentEffort{
                 activity: %Strava.MetaActivity{},
                 athlete: %Strava.MetaAthlete{},
                 segment: %Strava.SummarySegment{}
               } = segment_effort

        assert_present(segment_effort.name)
        assert is_number(segment_effort.id)
        assert is_number(segment_effort.elapsed_time)
        assert is_number(segment_effort.moving_time)
        assert %DateTime{} = segment_effort.start_date
        assert %DateTime{} = segment_effort.start_date_local

        assert_present(segment_effort.segment.name)
        assert [lat, long] = segment_effort.segment.start_latlng
        assert is_number(lat)
        assert is_number(long)

        assert [lat, long] = segment_effort.segment.end_latlng
        assert is_number(lat)
        assert is_number(long)
      end
    end

    test "#get_efforts_by_segment_id filtered by local start and end dates" do
      {:ok,
       [%Strava.DetailedSegmentEffort{start_date_local: start_date_local} = segment_effort | _]} =
        get_efforts_by_segment_id()

      use_cassette "segments/get_efforts_by_segment_id#filtered", match_requests_on: [:query] do
        client = Strava.Client.new()
        segment_id = segment_id()

        assert {:ok, segment_efforts} =
                 Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id,
                   start_date_local: DateTime.to_iso8601(start_date_local),
                   end_date_local: DateTime.to_iso8601(start_date_local)
                 )

        assert length(segment_efforts) == 1
        assert segment_efforts == [segment_effort]

        start_date_local = DateTime.from_unix!(DateTime.to_unix(start_date_local) - 86400)

        assert {:ok, []} =
                 Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id,
                   start_date_local: DateTime.to_iso8601(start_date_local),
                   end_date_local: DateTime.to_iso8601(start_date_local)
                 )
      end
    end
  end

  defp get_efforts_by_segment_id do
    use_cassette "segment_efforts/get_efforts_by_segment_id", match_requests_on: [:query] do
      client = Strava.Client.new()
      segment_id = segment_id()

      Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id)
    end
  end

  defp segment_id do
    Application.get_env(:strava, :test, [])[:segment_id] || System.get_env("STRAVA_SEGMENT_ID")
  end
end
