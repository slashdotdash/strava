defmodule Strava.AssertionHelpers do
  import ExUnit.Assertions

  def assert_present(string) when is_binary(string), do: refute(string == "")
  def assert_present(nil), do: flunk("Expected a string but got `nil`")

  def assert_lat_long([lat, long]) do
    assert is_number(lat)
    assert is_number(long)
  end

  def assert_lat_long(invalid), do: flunk("Expected a lat/long but got: " <> inspect(invalid))
end
