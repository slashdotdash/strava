defmodule Strava.SummarySegment do
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
    :athlete_pr_effort
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
          athlete_pr_effort: Strava.SummarySegmentEffort
        }
end

defimpl Poison.Decoder, for: Strava.SummarySegment do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:athlete_pr_effort, :struct, Strava.SummarySegmentEffort, options)
  end
end
