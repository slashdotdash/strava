defmodule Strava.SegmentTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Strava.Segment

  setup_all do
    HTTPoison.start
  end

  test "retrieve segment" do
    use_cassette "segment/retrieve#229781" do
      segment = Strava.Segment.retrieve(229781)

      assert segment != nil
      assert segment.name == "Hawk Hill"
    end
  end

  test "list segment efforts" do
    use_cassette "segment/list_efforts#229781" do
      segment_efforts = Strava.Segment.list_efforts(229781)

      assert segment_efforts != nil
      assert length(segment_efforts) == 30

      first_effort = hd(segment_efforts)
      assert first_effort.id == 1323785488
      assert first_effort.name == "Hawk Hill"

      assert first_effort.start_date == ~N[1970-01-01 00:29:39]
      assert first_effort.start_date_local == ~N[1969-12-31 16:29:39]
    end
  end

  test "list segment efforts, filtered by athlete" do
    use_cassette "segment/list_efforts#229781.athlete", match_requests_on: [:query] do
      segment_efforts = Strava.Segment.list_efforts(229781, %{athlete_id: 5287})

      assert segment_efforts != nil

      Enum.each(segment_efforts, fn(segment_effort) ->
        assert segment_effort.name == "Hawk Hill"
        assert segment_effort.athlete["id"] == 5287
      end)
    end
  end

  test "list segment efforts, filtered by start and end dates" do
    use_cassette "segment/list_efforts#229781.date", match_requests_on: [:query] do
      segment_efforts = Strava.Segment.list_efforts(229781, %{
        start_date_local: "2014-01-01T00:00:00Z",
        end_date_local: "2014-01-01T23:59:59Z"
      })

      assert segment_efforts != nil

      Enum.each(segment_efforts, fn(segment_effort) ->
        assert segment_effort.name == "Hawk Hill"

        assert segment_effort.start_date.year == 2014
        assert segment_effort.start_date.month == 1
        assert segment_effort.start_date.day == 1

        assert segment_effort.start_date_local.year == 2014
        assert segment_effort.start_date_local.month == 1
        assert segment_effort.start_date_local.day == 1
      end)
    end
  end

  test "stream segment efforts, filtered by start and end dates" do
    use_cassette "segment/stream_efforts#229781.date", match_requests_on: [:query] do
      segment_efforts = Strava.Segment.stream_efforts(229781, %{
        start_date_local: "2014-01-01T00:00:00Z",
        end_date_local: "2014-01-01T23:59:59Z"
      })
      |> Stream.take(5)
      |> Enum.to_list

      assert length(segment_efforts) == 5

      Enum.each(segment_efforts, fn(segment_effort) ->
        assert segment_effort.name == "Hawk Hill"

        assert segment_effort.start_date.year == 2014
        assert segment_effort.start_date.month == 1
        assert segment_effort.start_date.day == 1

        assert segment_effort.start_date_local.year == 2014
        assert segment_effort.start_date_local.month == 1
        assert segment_effort.start_date_local.day == 1
      end)
    end
  end

  test "stream segment efforts, filtered by start and end dates, for multiple pages" do
    use_cassette "segment/stream_efforts#229781.date2", match_requests_on: [:query] do
      segment_efforts = Strava.Segment.stream_efforts(229781, %{
        start_date_local: "2016-01-01T00:00:00Z",
        end_date_local: "2016-01-31T23:59:59Z"
      })
      |> Enum.to_list

      assert length(segment_efforts) > 0

      Enum.each(segment_efforts, fn(segment_effort) ->
        assert segment_effort.name == "Hawk Hill"

        assert segment_effort.start_date_local.year == 2016
        assert segment_effort.start_date_local.month == 1
      end)
    end
  end
end
