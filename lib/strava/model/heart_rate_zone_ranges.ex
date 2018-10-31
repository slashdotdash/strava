defmodule Strava.HeartRateZoneRanges do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :custom_zones,
    :zones
  ]

  @type t :: %__MODULE__{
          custom_zones: boolean(),
          zones: list(Strava.ZoneRange)
        }
end

defimpl Poison.Decoder, for: Strava.HeartRateZoneRanges do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:zones, :list, Strava.ZoneRange, options)
  end
end
