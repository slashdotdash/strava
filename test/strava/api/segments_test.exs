defmodule Strava.SegmentTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "segments" do
    test "#get_segment_by_id" do
      use_cassette "segments/get_segment_by_id", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.DetailedSegment{
           id: id,
           name: name,
           created_at: created_at,
           updated_at: updated_at,
           start_latlng: start_latlng,
           end_latlng: end_latlng,
           map: %Strava.PolylineMap{} = map
         }} = Strava.Segments.get_segment_by_id(client, "229781")

        assert name == "Hawk Hill"
        assert is_number(id)
        assert created_at == DateTime.from_naive!(~N[2009-09-21 20:29:41], "Etc/UTC")
        assert %DateTime{} = updated_at
        assert start_latlng == [37.8331119, -122.4834356]
        assert end_latlng == [37.8280722, -122.4981393]
        assert map.id == "s229781"

        assert map.polyline ==
                 "}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@"
      end
    end

    test "#get_logged_in_athlete_starred_segments" do
      use_cassette "segments/get_logged_in_athlete_starred_segments", match_requests_on: [:query] do
        client = Strava.Client.new()

        assert {:ok, starred_segments} =
                 Strava.Segments.get_logged_in_athlete_starred_segments(client)

        for segment <- starred_segments do
          %Strava.SummarySegment{
            id: id,
            name: name,
            start_latlng: start_latlng,
            end_latlng: end_latlng
          } = segment

          assert is_number(id)
          assert_present(name)
          assert_lat_long(start_latlng)
          assert_lat_long(end_latlng)
        end
      end
    end

    test "#get_leaderboard_by_segment_id" do
      use_cassette "segments/get_leaderboard_by_segment_id", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.SegmentLeaderboard{
           entries: entries,
           kom_type: kom_type,
           entry_count: entry_count,
           effort_count: effort_count
         }} = Strava.Segments.get_leaderboard_by_segment_id(client, "229781")

        refute entries == []
        assert_present(kom_type)
        assert is_number(effort_count)
        assert is_number(entry_count)

        for entry <- entries do
          %Strava.SegmentLeaderboardEntry{
            athlete_name: athlete_name,
            elapsed_time: elapsed_time,
            moving_time: moving_time,
            rank: rank,
            start_date: start_date,
            start_date_local: start_date_local
          } = entry

          assert_present(athlete_name)
          assert is_number(elapsed_time)
          assert is_number(moving_time)
          assert is_number(rank)
          assert %DateTime{} = start_date
          assert %DateTime{} = start_date_local
        end
      end
    end

    test "#explore_segments" do
      use_cassette "segments/explore_segments", match_requests_on: [:query] do
        client = Strava.Client.new()

        assert {:ok, %Strava.ExplorerResponse{segments: explored_segments}} =
                 Strava.Segments.explore_segments(client, [
                   37.821362,
                   -122.505373,
                   37.842038,
                   -122.465977
                 ])

        refute explored_segments == []

        for segment <- explored_segments do
          assert %Strava.ExplorerSegment{} = segment

          assert_present(segment.name)
          assert_present(segment.points)
          assert is_number(segment.id)
          assert is_number(segment.avg_grade)
          assert is_number(segment.distance)
          assert is_number(segment.elev_difference)
          assert_lat_long(segment.start_latlng)
          assert_lat_long(segment.end_latlng)
        end
      end
    end
  end
end
