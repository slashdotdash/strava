defmodule Strava.Zones do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :heart_rate,
    :power
  ]

  @type t :: %__MODULE__{
          heart_rate: Strava.HeartRateZoneRanges.t(),
          power: Strava.PowerZoneRanges.t()
        }
end

defimpl Poison.Decoder, for: Strava.Zones do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:heart_rate, :struct, Strava.HeartRateZoneRanges, options)
    |> deserialize(:power, :struct, Strava.PowerZoneRanges, options)
  end
end
