defmodule Strava.Map do
  @moduledoc """
  Activity and segment API requests may include summary polylines of their respective routes.
  The values are string encodings of the latitude and longitude points using the [Google encoded polyline algorithm format](https://developers.google.com/maps/documentation/utilities/polylinealgorithm).

  More info: http://strava.github.io/api/#polylines
  """

  @type t :: %__MODULE__{
    id: String.t,
    polyline: String.t,
    summary_polyline: String.t,
    resource_state: integer,
  }

  defstruct [
    :id,
    :polyline,
    :summary_polyline,
    :resource_state,
  ]
end
