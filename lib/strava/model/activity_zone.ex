defmodule Strava.ActivityZone do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :score,
    :distribution_buckets,
    :type,
    :sensor_based,
    :points,
    :custom_zones,
    :max
  ]

  @type t :: %__MODULE__{
          score: integer(),
          distribution_buckets: list(Strava.TimedZoneRange.t()),
          type: String.t(),
          sensor_based: boolean(),
          points: integer(),
          custom_zones: boolean(),
          max: integer()
        }
end

defimpl Poison.Decoder, for: Strava.ActivityZone do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:distribution_buckets, :list, Strava.TimedZoneRange, options)
  end
end
