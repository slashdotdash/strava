defmodule Strava.SummaryActivity do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :external_id,
    :upload_id,
    :athlete,
    :name,
    :distance,
    :moving_time,
    :elapsed_time,
    :total_elevation_gain,
    :elev_high,
    :elev_low,
    :type,
    :start_date,
    :start_date_local,
    :timezone,
    :start_latlng,
    :end_latlng,
    :achievement_count,
    :kudos_count,
    :comment_count,
    :athlete_count,
    :photo_count,
    :total_photo_count,
    :map,
    :trainer,
    :commute,
    :manual,
    :private,
    :flagged,
    :workout_type,
    :average_speed,
    :max_speed,
    :has_kudoed,
    :gear_id,
    :kilojoules,
    :average_watts,
    :device_watts,
    :max_watts,
    :weighted_average_watts
  ]

  @type t :: %__MODULE__{
          id: integer(),
          external_id: String.t(),
          upload_id: integer(),
          athlete: Strava.MetaAthlete,
          name: String.t(),
          distance: float(),
          moving_time: integer(),
          elapsed_time: integer(),
          total_elevation_gain: float(),
          elev_high: float(),
          elev_low: float(),
          type: String.t(),
          start_date: DateTime.t(),
          start_date_local: DateTime.t(),
          timezone: String.t(),
          start_latlng: list(float()),
          end_latlng: list(float()),
          achievement_count: integer(),
          kudos_count: integer(),
          comment_count: integer(),
          athlete_count: integer(),
          photo_count: integer(),
          total_photo_count: integer(),
          map: Strava.PolylineMap,
          trainer: boolean(),
          commute: boolean(),
          manual: boolean(),
          private: boolean(),
          flagged: boolean(),
          workout_type: integer(),
          average_speed: float(),
          max_speed: float(),
          has_kudoed: boolean(),
          gear_id: String.t(),
          kilojoules: float(),
          average_watts: float(),
          device_watts: boolean(),
          max_watts: integer(),
          weighted_average_watts: integer()
        }
end

defimpl Poison.Decoder, for: Strava.SummaryActivity do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:athlete, :struct, Strava.MetaAthlete, options)
    |> deserialize(:start_date, :datetime, options)
    |> deserialize(:start_date_local, :datetime, options)
    |> deserialize(:map, :struct, Strava.PolylineMap, options)
  end
end
