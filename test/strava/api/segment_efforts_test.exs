defmodule Strava.SegmentEffortsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "segment efforts" do
    test "#get_efforts_by_segment_id" do
      assert {:ok, segment_efforts} = get_efforts_by_segment_id()

      assert_segment_efforts(segment_efforts)
    end

    test "#get_efforts_by_segment_id filtered by local start and end dates" do
      {:ok, segment_efforts} = get_efforts_by_segment_id()

      [%Strava.DetailedSegmentEffort{start_date_local: start_date_local} = segment_effort | _] =
        segment_efforts

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

  test "stream segment efforts" do
    use_cassette "stream_segment_efforts/get_efforts_by_segment_id", match_requests_on: [:query] do
      client = Strava.Client.new()
      segment_id = segment_id()

      stream =
        Strava.Paginator.stream(
          fn pagination ->
            Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id, pagination)
          end,
          per_page: 5
        )

      segment_efforts = stream |> Stream.take(10) |> Enum.to_list()

      assert_segment_efforts(segment_efforts)
    end
  end

  defp get_efforts_by_segment_id do
    use_cassette "segment_efforts/get_efforts_by_segment_id", match_requests_on: [:query] do
      client = Strava.Client.new()
      segment_id = segment_id()

      Strava.SegmentEfforts.get_efforts_by_segment_id(client, segment_id)
    end
  end

  defp assert_segment_efforts(segment_efforts) do
    for segment_effort <- segment_efforts do
      %Strava.DetailedSegmentEffort{
        id: id,
        name: name,
        elapsed_time: elapsed_time,
        moving_time: moving_time,
        start_date: start_date,
        start_date_local: start_date_local,
        activity: %Strava.MetaActivity{},
        athlete: %Strava.MetaAthlete{},
        segment: %Strava.SummarySegment{} = segment
      } = segment_effort

      assert_present(name)
      assert is_number(id)
      assert is_number(elapsed_time)
      assert is_number(moving_time)
      assert %DateTime{} = start_date
      assert %DateTime{} = start_date_local

      assert_present(segment.name)
      assert_lat_long(segment.start_latlng)
      assert_lat_long(segment.end_latlng)
    end
  end

  defp segment_id do
    Application.get_env(:strava, :test, [])[:segment_id] || System.get_env("STRAVA_SEGMENT_ID")
  end
end
