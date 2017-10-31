defmodule Strava.SegmentLeaderboard do
  @moduledoc """
  A segment leaderboard represents athlete’s attempts at a segment.

  More info: http://strava.github.io/api/v3/segments/#leaderboard
  """
  defstruct [:entry_count, :entries]
end
