defmodule Strava.ActivityTotal do
  @moduledoc """
  A roll-up of metrics pertaining to a set of activities. Values are in seconds and meters.
  """

  @derive [Poison.Encoder]
  defstruct [
    :count,
    :distance,
    :moving_time,
    :elapsed_time,
    :elevation_gain,
    :achievement_count
  ]

  @type t :: %__MODULE__{
          count: integer(),
          distance: float(),
          moving_time: integer(),
          elapsed_time: integer(),
          elevation_gain: float(),
          achievement_count: integer()
        }
end
