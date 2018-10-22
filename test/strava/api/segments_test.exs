defmodule Strava.SegmentTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "segments" do
    test "#get_segment_by_id" do
      use_cassette "segments/get_segment_by_id" do
        client = Strava.Client.new()

        assert {:ok, %Strava.DetailedSegment{} = segment} =
                 Strava.Segments.get_segment_by_id(client, "229781")

        assert segment.name == "Hawk Hill"
        assert is_number(segment.id)
        assert segment.created_at == DateTime.from_naive!(~N[2009-09-21 20:29:41], "Etc/UTC")
        assert %DateTime{} = segment.updated_at

        assert [lat, long] = segment.start_latlng
        assert is_number(lat)
        assert is_number(long)

        assert [lat, long] = segment.end_latlng
        assert is_number(lat)
        assert is_number(long)

        assert segment.map.id == "s229781"

        assert segment.map.polyline ==
                 "}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@"
      end
    end
  end
end
