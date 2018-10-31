defmodule Strava.ZoneRange do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :min,
    :max
  ]

  @type t :: %__MODULE__{
          min: integer(),
          max: integer()
        }
end
