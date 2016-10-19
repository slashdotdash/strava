defmodule Strava.Activity do
  @moduledoc """
  Activities are the base object for Strava runs, rides, swims etc.

  More info: https://strava.github.io/api/v3/activities/
  """

  @type t :: %Strava.Activity {
    id: number,
    resource_state: number,
    external_id: String.t,
    upload_id: number,
    #athlete:
    name: String.t,
    description: String.t,
    distance: number,
    moving_time: number,
    elapsed_time: number,
    total_elevation_gain: number,
    elev_high: number,
    elev_low: number,
    type: String.t,
    # start_date: String.t,
    # start_date_local: String.t,
    timezone: String.t,
    start_latlng: list(number),
    end_latlng: list(number),
    achievement_count: number,
    kudos_count: number,
    comment_count: number,
    athlete_count: number,
    photo_count: number,
    total_photo_count: number,
    # photos:
    # map:
    trainer: boolean,
    commute: boolean,
    manual: boolean,
    private: boolean,
    device_name: String.t,
    embed_token: String.t,
    flagged: boolean,
    workout_type: number,
    gear_id: String.t,
    # gear:
    average_speed: number,
    max_speed: number,
    average_cadence: number,
    average_temp: number,
    average_watts: number,
    max_watts: number,
    weighted_average_watts: number,
    kilojoules: number,
    device_watts: boolean,
    has_heartrate: boolean,
    average_heartrate: number,
    max_heartrate: number,
    calories: number,
    suffer_score: number,
    has_kudoed: boolean,
    # segment_efforts:
    # splits_metric:
    # splits_standard:
    # best_efforts:
  }

  defstruct [
    :id,
    :resource_state,
    :external_id,
    :upload_id,
    # :athlete,
    :name,
    :description,
    :distance,
    :moving_time,
    :elapsed_time,
    :total_elevation_gain,
    :elev_high,
    :elev_low,
    :type,
    # :start_date,
    # :start_date_local,
    :timezone,
    :start_latlng,
    :end_latlng,
    :achievement_count,
    :kudos_count,
    :comment_count,
    :athlete_count,
    :photo_count,
    :total_photo_count,
    # :photos,
    # :map,
    :trainer,
    :commute,
    :manual,
    :private,
    :device_name,
    :embed_token,
    :flagged,
    :workout_type,
    :gear_id,
    # :gear,
    :average_speed,
    :max_speed,
    :average_cadence,
    :average_temp,
    :average_watts,
    :max_watts,
    :weighted_average_watts,
    :kilojoules,
    :device_watts,
    :has_heartrate,
    :average_heartrate,
    :max_heartrate,
    :calories,
    :suffer_score,
    :has_kudoed,
    # :segment_efforts,
    # :splits_metric,
    # :splits_standard,
    # :best_efforts,
  ]

  @doc """
  Retrieve details about a specific activity.

  ## Example

      Strava.Activity.retrieve(746805584)

  More info at: https://strava.github.io/api/v3/activities/#get-details
  """
  @spec retrieve(number) :: %Strava.Activity{}
  def retrieve(id) do
    Strava.request("activities/#{id}", as: %Strava.Activity{})
  end
end
