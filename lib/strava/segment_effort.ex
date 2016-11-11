defmodule Strava.SegmentEffort do
  import Strava.Util, only: [parse_date: 1]

  @moduledoc """
  A segment effort represents an athlete’s attempt at a segment. It can also be thought of as a portion of a ride that covers a segment.

  More info: https://strava.github.io/api/v3/efforts/
  """

  @type t :: %__MODULE__{
    id: integer,
    resource_state: integer,
    name: String.t,
    activity: Strava.Activity.Meta.t,
    athlete: Strava.Athlete.Meta.t,
    elapsed_time: integer,
    moving_time: integer,
    start_date: NaiveDateTime.t | String.t,
    start_date_local: NaiveDateTime.t | String.t,
    distance: float,
    start_index: integer,
    end_index: integer,
    average_cadence: float,
    average_watts: float,
    device_watts: boolean,
    average_heartrate: float,
    max_heartrate: integer,
    segment: Strava.Segment.t,
    kom_rank: integer,
    pr_rank: integer,
    hidden: boolean
  }

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

  More info: https://strava.github.io/api/v3/efforts/#retrieve
  """
  @spec retrieve(integer) :: Strava.SegmentEffort.t
  def retrieve(id) do
    "segment_efforts/#{id}"
    |> Strava.request(as: %Strava.SegmentEffort{})
    |> parse
  end

  @doc """
  Parse the dates and segment in the segment effort
  """
  @spec parse(Strava.SegmentEffort.t) :: Strava.SegmentEffort.t
  def parse(%Strava.SegmentEffort{} = segment_effort) do
    segment_effort
    |> parse_dates
    |> parse_segment
  end

  @spec parse_dates(Strava.SegmentEffort.t) :: Strava.SegmentEffort.t
  defp parse_dates(%Strava.SegmentEffort{start_date: start_date, start_date_local: start_date_local} = segment_effort) do
    %Strava.SegmentEffort{segment_effort |
      start_date: parse_date(start_date),
      start_date_local: parse_date(start_date_local)
    }
  end

  @spec parse_segment(Strava.SegmentEffort.t) :: Strava.SegmentEffort.t
  defp parse_segment(%Strava.SegmentEffort{segment: segment} = segment_effort) do
    %Strava.SegmentEffort{segment_effort |
      segment: struct(Strava.Segment, segment)
    }
  end
end
