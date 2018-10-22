defmodule Strava.TimedZoneRange do
  @moduledoc """
  A union type representing the time spent in a given zone.
  """

  @derive [Poison.Encoder]
  defstruct [
    :min,
    :max,
    :time
  ]

  @type t :: %__MODULE__{
          min: integer(),
          max: integer(),
          time: integer()
        }
end
