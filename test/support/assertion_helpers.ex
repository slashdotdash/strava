defmodule Strava.AssertionHelpers do
  import ExUnit.Assertions

  def assert_present(string) when is_binary(string), do: refute(string == "")
  def assert_present(nil), do: flunk("Expected a string but got `nil`")
end
