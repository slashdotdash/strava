defmodule Strava.Athlete.Stats do
  @moduledoc """
  Returns recent (last 4 weeks), year to date and all time stats for a given
  athlete. Only available for the authenticated athlete. This is the
  recommended endpoint when polling for athlete upload events.

  More info: http://strava.github.io/api/v3/athlete/#stats
  """

  @type t :: %__MODULE__ {
    biggest_ride_distance: float,
    biggest_climb_elevation_gain: float,
    recent_ride_totals: Strava.Athlete.Stats.RecentTotals.t,
    recent_run_totals: Strava.Athlete.Stats.RecentTotals.t,
    recent_swim_totals: Strava.Athlete.Stats.RecentTotals.t,
    ytd_ride_totals: Strava.Athlete.Stats.Totals.t,
    ytd_run_totals: Strava.Athlete.Stats.Totals.t,
    ytd_swim_totals: Strava.Athlete.Stats.Totals.t,
    all_ride_totals: Strava.Athlete.Stats.Totals.t,
    all_run_totals: Strava.Athlete.Stats.Totals.t,
    all_swim_totals: Strava.Athlete.Stats.Totals.t
  }

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
    :all_swim_totals,
  ]

  @spec parse(Strava.Athlete.Stats.t) :: Strava.Athlete.Stats.t
  def parse(stats) do
    %Strava.Athlete.Stats{stats|
      recent_ride_totals: struct(Strava.Athlete.Stats.RecentTotals, stats.recent_ride_totals),
      recent_run_totals: struct(Strava.Athlete.Stats.RecentTotals, stats.recent_run_totals),
      recent_swim_totals: struct(Strava.Athlete.Stats.RecentTotals, stats.recent_swim_totals),
    }
  end

  defmodule RecentTotals do
    @type t :: %__MODULE__ {
      achievement_count: integer,
      count: integer,
      distance: float,
      elapsed_time: integer,
      elevation_gain: float,
      moving_time: integer
    }

    defstruct [
      :achievement_count,
      :count,
      :distance,
      :elapsed_time,
      :elevation_gain,
      :moving_time,
    ]
  end

  defmodule Totals do
    @type t :: %__MODULE__ {
      count: integer,
      distance: integer,
      elapsed_time: integer,
      elevation_gain: integer,
      moving_time: integer
    }

    defstruct [
      :count,
      :distance,
      :elapsed_time,
      :elevation_gain,
      :moving_time,
    ]
  end
end
