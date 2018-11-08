defmodule Strava.ActivityStats do
  @moduledoc """
  A set of rolled-up statistics and totals for an athlete
  """

  @derive [Poison.Encoder]
  defstruct [
    :biggest_ride_distance,
    :biggest_climb_elevation_gain,
    :recent_ride_totals,
    :recent_run_totals,
    :recent_swim_totals,
    :ytd_ride_totals,
    :ytd_run_totals,
    :ytd_swim_totals,
    :all_ride_totals,
    :all_run_totals,
    :all_swim_totals
  ]

  @type t :: %__MODULE__{
          biggest_ride_distance: float(),
          biggest_climb_elevation_gain: float(),
          recent_ride_totals: Strava.ActivityTotal.t(),
          recent_run_totals: Strava.ActivityTotal.t(),
          recent_swim_totals: Strava.ActivityTotal.t(),
          ytd_ride_totals: Strava.ActivityTotal.t(),
          ytd_run_totals: Strava.ActivityTotal.t(),
          ytd_swim_totals: Strava.ActivityTotal.t(),
          all_ride_totals: Strava.ActivityTotal.t(),
          all_run_totals: Strava.ActivityTotal.t(),
          all_swim_totals: Strava.ActivityTotal.t()
        }
end

defimpl Poison.Decoder, for: Strava.ActivityStats do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:recent_ride_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:recent_run_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:recent_swim_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:ytd_ride_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:ytd_run_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:ytd_swim_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:all_ride_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:all_run_totals, :struct, Strava.ActivityTotal, options)
    |> deserialize(:all_swim_totals, :struct, Strava.ActivityTotal, options)
  end
end
