defmodule Strava.RunningRace do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :running_race_type,
    :distance,
    :start_date_local,
    :city,
    :state,
    :country,
    :route_ids,
    :measurement_preference,
    :url,
    :website_url
  ]

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          running_race_type: integer(),
          distance: float(),
          start_date_local: DateTime.t(),
          city: String.t(),
          state: String.t(),
          country: String.t(),
          route_ids: [integer()],
          measurement_preference: String.t(),
          url: String.t(),
          website_url: String.t()
        }
end
