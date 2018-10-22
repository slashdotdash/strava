defmodule Strava.UtilTest do
  use ExUnit.Case, async: true
  alias Strava.Util

  test "parse_date" do
    assert Util.parse_date(nil) == nil
    assert Util.parse_date("2012-05-16T21:37:06Z") == ~N[2012-05-16 21:37:06]
  end

  test "query string no pagination" do
    assert Util.query_string_no_pagination(%{test_param: 76, second_param: 4}) ==
             "second_param=4&test_param=76"
  end

  test "query string" do
    pagination = %Strava.Pagination{per_page: 200, page: 1}
    assert Util.query_string(pagination, %{test_param: 76}) == "page=1&per_page=200&test_param=76"
  end
end
