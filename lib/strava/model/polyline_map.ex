defmodule Strava.PolylineMap do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :polyline,
    :summary_polyline
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          polyline: String.t(),
          summary_polyline: String.t()
        }
end
