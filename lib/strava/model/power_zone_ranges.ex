defmodule Strava.PowerZoneRanges do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :zones
  ]

  @type t :: %__MODULE__{
          zones: list(Strava.ZoneRange.t())
        }
end

defimpl Poison.Decoder, for: Strava.PowerZoneRanges do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:zones, :list, Strava.ZoneRange, options)
  end
end
