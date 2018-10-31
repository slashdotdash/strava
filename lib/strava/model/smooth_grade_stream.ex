defmodule Strava.SmoothGradeStream do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :original_size,
    :resolution,
    :series_type,
    :data
  ]

  @type t :: %__MODULE__{
          original_size: integer(),
          resolution: String.t(),
          series_type: String.t(),
          data: [float()]
        }
end
