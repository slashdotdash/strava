defmodule Strava.Route do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :athlete,
    :description,
    :distance,
    :elevation_gain,
    :id,
    :map,
    :name,
    :private,
    :starred,
    :timestamp,
    :type,
    :sub_type,
    :segments,
    :directions
  ]

  @type t :: %__MODULE__{
          athlete: Strava.SummaryAthlete,
          description: String.t(),
          distance: float(),
          elevation_gain: float(),
          id: integer(),
          map: Strava.PolylineMap,
          name: String.t(),
          private: boolean(),
          starred: boolean(),
          timestamp: integer(),
          type: integer(),
          sub_type: integer(),
          segments: [Strava.SummarySegment],
          directions: [Strava.RouteDirection]
        }
end

defimpl Poison.Decoder, for: Strava.Route do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:athlete, :struct, Strava.SummaryAthlete, options)
    |> deserialize(:map, :struct, Strava.PolylineMap, options)
    |> deserialize(:segments, :list, Strava.SummarySegment, options)
    |> deserialize(:directions, :list, Strava.RouteDirection, options)
  end
end
