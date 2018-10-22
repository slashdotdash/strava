defmodule Strava.Split do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :average_speed,
    :distance,
    :elapsed_time,
    :elevation_difference,
    :pace_zone,
    :moving_time,
    :split
  ]

  @type t :: %__MODULE__{
          average_speed: float(),
          distance: float(),
          elapsed_time: integer(),
          elevation_difference: float(),
          pace_zone: integer(),
          moving_time: integer(),
          split: integer()
        }
end
