defmodule Strava.Lap do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :activity,
    :athlete,
    :average_cadence,
    :average_speed,
    :distance,
    :elapsed_time,
    :start_index,
    :end_index,
    :lap_index,
    :max_speed,
    :moving_time,
    :name,
    :pace_zone,
    :split,
    :start_date,
    :start_date_local,
    :total_elevation_gain
  ]

  @type t :: %__MODULE__{
          id: integer(),
          activity: Strava.MetaActivity.t(),
          athlete: Strava.MetaAthlete.t(),
          average_cadence: float(),
          average_speed: float(),
          distance: float(),
          elapsed_time: integer(),
          start_index: integer(),
          end_index: integer(),
          lap_index: integer(),
          max_speed: float(),
          moving_time: integer(),
          name: String.t(),
          pace_zone: integer(),
          split: integer(),
          start_date: DateTime.t(),
          start_date_local: DateTime.t(),
          total_elevation_gain: float()
        }
end

defimpl Poison.Decoder, for: Strava.Lap do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:activity, :struct, Strava.MetaActivity, options)
    |> deserialize(:athlete, :struct, Strava.MetaAthlete, options)
    |> deserialize(:start_date, :datetime, options)
    |> deserialize(:start_date_local, :datetime, options)
  end
end
