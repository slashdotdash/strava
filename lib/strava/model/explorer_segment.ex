defmodule Strava.ExplorerSegment do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :climb_category,
    :climb_category_desc,
    :avg_grade,
    :start_latlng,
    :end_latlng,
    :elev_difference,
    :distance,
    :points
  ]

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          climb_category: integer(),
          climb_category_desc: String.t(),
          avg_grade: float(),
          start_latlng: list(float()),
          end_latlng: list(float()),
          elev_difference: float(),
          distance: float(),
          points: String.t()
        }
end
