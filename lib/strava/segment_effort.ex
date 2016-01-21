defmodule Strava.SegmentEffort do
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
    Strava.request("segment_efforts/#{id}", as: %Strava.SegmentEffort{})
  end
end