defmodule Strava.DetailedSegment do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :activity_type,
    :distance,
    :average_grade,
    :maximum_grade,
    :elevation_high,
    :elevation_low,
    :start_latlng,
    :end_latlng,
    :climb_category,
    :city,
    :state,
    :country,
    :private,
    :athlete_pr_effort,
    :created_at,
    :updated_at,
    :total_elevation_gain,
    :map,
    :effort_count,
    :athlete_count,
    :hazardous,
    :star_count
  ]

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          activity_type: String.t(),
          distance: float(),
          average_grade: float(),
          maximum_grade: float(),
          elevation_high: float(),
          elevation_low: float(),
          start_latlng: list(float()),
          end_latlng: list(float()),
          climb_category: integer(),
          city: String.t(),
          state: String.t(),
          country: String.t(),
          private: boolean(),
          athlete_pr_effort: Strava.SummarySegmentEffort,
          created_at: DateTime.t(),
          updated_at: DateTime.t(),
          total_elevation_gain: float(),
          map: Strava.PolylineMap,
          effort_count: integer(),
          athlete_count: integer(),
          hazardous: boolean(),
          star_count: integer()
        }
end

defimpl Poison.Decoder, for: Strava.DetailedSegment do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:athlete_pr_effort, :struct, Strava.SummarySegmentEffort, options)
    |> deserialize(:created_at, :datetime, options)
    |> deserialize(:updated_at, :datetime, options)
    |> deserialize(:map, :struct, Strava.PolylineMap, options)
  end
end
