defmodule Strava.SegmentEffort do
  import Strava.Util, only: [parse_date: 1]

  @moduledoc """
  A segment effort represents an athlete’s attempt at a segment. It can also be thought of as a portion of a ride that covers a segment.

  More info: https://strava.github.io/api/v3/efforts/
  """
  defstruct [
    :id,
    :resource_state,
    :name,
    :activity,
    :athlete,
    :elapsed_time,
    :moving_time,
    :start_date,
    :start_date_local,
    :distance,
    :start_index,
    :end_index,
    :average_cadence,
    :average_watts,
    :device_watts,
    :average_heartrate,
    :max_heartrate,
    :segment,
    :kom_rank,
    :pr_rank,
    :hidden
  ]

  @doc """
  A segment effort represents an athlete’s attempt at a segment. It can also be thought of as a portion of a ride that covers a segment.

  ## Example

      Strava.SegmentEffort.retrieve(269990681)

  More info at: https://strava.github.io/api/v3/efforts/#retrieve
  """
  @spec retrieve(number) :: %Strava.SegmentEffort{}
  def retrieve(id) do
    "segment_efforts/#{id}"
    |> Strava.request(as: %Strava.SegmentEffort{})
    |> parse
  end

  @doc """
  Parse the dates in the segment effort to naive date time structs
  """
  @spec parse(%Strava.SegmentEffort{}) :: %Strava.SegmentEffort{}
  def parse(%Strava.SegmentEffort{} = segment_effort) do
    segment_effort
    |> parse_dates
  end

  defp parse_dates(%Strava.SegmentEffort{start_date: start_date, start_date_local: start_date_local} = segment_effort) do
    %Strava.SegmentEffort{segment_effort |
      start_date: parse_date(start_date),
      start_date_local: parse_date(start_date_local)
    }
  end
end
