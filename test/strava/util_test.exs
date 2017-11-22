defmodule Strava.UtilTest do
  use ExUnit.Case, async: true
  alias Strava.Util

  test "parse_date" do
    assert Util.parse_date(nil) == nil
    assert Util.parse_date("2012-05-16T21:37:06Z") == ~N[2012-05-16 21:37:06]
  end
end
