defmodule Strava.DetailedSegmentEffort do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :elapsed_time,
    :start_date,
    :start_date_local,
    :distance,
    :is_kom,
    :name,
    :activity,
    :athlete,
    :moving_time,
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

  @type t :: %__MODULE__{
          id: integer(),
          elapsed_time: integer(),
          start_date: DateTime.t(),
          start_date_local: DateTime.t(),
          distance: float(),
          is_kom: boolean(),
          name: String.t(),
          activity: Strava.MetaActivity.t(),
          athlete: Strava.MetaAthlete.t(),
          moving_time: integer(),
          start_index: integer(),
          end_index: integer(),
          average_cadence: float(),
          average_watts: float(),
          device_watts: boolean(),
          average_heartrate: float(),
          max_heartrate: float(),
          segment: Strava.SummarySegment.t(),
          kom_rank: integer(),
          pr_rank: integer(),
          hidden: boolean()
        }
end

defimpl Poison.Decoder, for: Strava.DetailedSegmentEffort do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:start_date, :datetime, options)
    |> deserialize(:start_date_local, :datetime, options)
    |> deserialize(:activity, :struct, Strava.MetaActivity, options)
    |> deserialize(:athlete, :struct, Strava.MetaAthlete, options)
    |> deserialize(:segment, :struct, Strava.SummarySegment, options)
  end
end
