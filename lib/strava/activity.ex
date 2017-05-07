defmodule Strava.Activity do
  @moduledoc """
  Activities are the base object for Strava runs, rides, swims etc.

  More info: https://strava.github.io/api/v3/activities/
  """

  import Strava.Util, only: [parse_date: 1]

  @type t :: %__MODULE__{
    id: integer,
    resource_state: integer,
    external_id: String.t,
    upload_id: integer,
    athlete: Strava.Athlete.Meta.t,
    name: String.t,
    description: String.t,
    distance: float,
    moving_time: integer,
    elapsed_time: integer,
    total_elevation_gain: float,
    elev_high: float,
    elev_low: float,
    type: String.t,
    start_date: NaiveDateTime.t | String.t,
    start_date_local: NaiveDateTime.t | String.t,
    timezone: String.t,
    start_latlng: list(number),
    end_latlng: list(number),
    achievement_count: integer,
    kudos_count: integer,
    comment_count: integer,
    athlete_count: integer,
    photo_count: integer,
    total_photo_count: integer,
    photos: Strava.Activity.Photo.Summary.t | nil,
    map: map,
    trainer: boolean,
    commute: boolean,
    manual: boolean,
    private: boolean,
    device_name: String.t,
    embed_token: String.t,
    flagged: boolean,
    workout_type: integer,
    gear_id: String.t,
    gear: map,
    average_speed: float,
    max_speed: float,
    average_cadence: float,
    average_temp: float,
    average_watts: float,
    max_watts: integer,
    weighted_average_watts: integer,
    kilojoules: float,
    device_watts: boolean,
    has_heartrate: boolean,
    average_heartrate: float,
    max_heartrate: integer,
    calories: float,
    suffer_score: integer,
    has_kudoed: boolean,
    segment_efforts: list(Strava.SegmentEffort.t) | nil,
    splits_metric: list(map),
    splits_standard: list(map),
    best_efforts: list(map)
  }

  defstruct [
    :id,
    :resource_state,
    :external_id,
    :upload_id,
    :athlete,
    :name,
    :description,
    :distance,
    :moving_time,
    :elapsed_time,
    :total_elevation_gain,
    :elev_high,
    :elev_low,
    :type,
    :start_date,
    :start_date_local,
    :timezone,
    :start_latlng,
    :end_latlng,
    :achievement_count,
    :kudos_count,
    :comment_count,
    :athlete_count,
    :photo_count,
    :total_photo_count,
    :photos,
    :map,
    :trainer,
    :commute,
    :manual,
    :private,
    :device_name,
    :embed_token,
    :flagged,
    :workout_type,
    :gear_id,
    :gear,
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
    :segment_efforts,
    :splits_metric,
    :splits_standard,
    :best_efforts
  ]

  defmodule Meta do
    @type t :: %__MODULE__{
      id: integer,
      resource_state: integer
    }

    defstruct [
      :id,
      :resource_state
    ]
  end

  defmodule Pagination do
    @type t :: %__MODULE__{
      page: integer,
      per_page: integer,
      before: NaiveDateTime.t | String.t,
      after: NaiveDateTime.t | String.t
    } | Strava.Pagination.t

    defstruct [
      :page,
      :per_page,
      :before,
      :after
    ]
  end

  @doc """
  Retrieve details about a specific activity.

  ## Example

      Strava.Activity.retrieve(746805584)

  More info: https://strava.github.io/api/v3/activities/#get-details
  """
  @spec retrieve(integer) :: Strava.Activity.t
  def retrieve(id, client \\ Strava.Client.new) do
    "activities/#{id}"
    |> Strava.request(client, as: %Strava.Activity{})
    |> parse
  end

  @doc """
  Retrieve a list of activities for the authenticated user. Pagination is supported.

  ## Example

      activities = Strava.Activity.list_athlete_activities(%Strava.Pagination{per_page: 200, page: 1})
      activities = Strava.Activity.list_athlete_activities(%Strava.Pagination{per_page: 200, page: 1}, Strava.Client.new("<access_token>>"))
      activities = Strava.Activity.list_athlete_activities(%Strava.Activity.Pagination{before: "2017-04-20T00:00:12Z"})

  More info: https://strava.github.io/api/v3/activities/#get-activities
  """
  @spec list_athlete_activities(Strava.Activity.Pagination.t, Strava.Client.t) :: list(Strava.Activity.t)
  def list_athlete_activities(pagination, client \\ Strava.Client.new) do
    "athlete/activities?#{URI.encode_query(Map.from_struct(pagination))}"
    |> Strava.request(client, as: [%Strava.Activity{}])
    |> Enum.map(&Strava.Activity.parse/1)
  end

  @doc """
  Parse the athlete, dates, photos and segment efforts in the activity
  """
  @spec parse(Strava.Activity.t) :: Strava.Activity.t
  def parse(%Strava.Activity{} = activity) do
    activity
    |> parse_athlete
    |> parse_dates
    |> parse_photos
    |> parse_segment_efforts
  end

  @spec parse_athlete(Strava.Activity.t) :: Strava.Activity.t
  defp parse_athlete(%Strava.Activity{athlete: athlete} = activity) do
    %Strava.Activity{activity |
      athlete: struct(Strava.Athlete.Meta, athlete)
    }
  end

  @spec parse_dates(Strava.Activity.t) :: Strava.Activity.t
  defp parse_dates(%Strava.Activity{start_date: start_date, start_date_local: start_date_local} = activity) do
    %Strava.Activity{activity |
      start_date: parse_date(start_date),
      start_date_local: parse_date(start_date_local)
    }
  end

  @spec parse_photos(Strava.Activity.t) :: Strava.Activity.t
  defp parse_photos(activity)
  defp parse_photos(%Strava.Activity{photos: nil} = activity), do: activity
  defp parse_photos(%Strava.Activity{photos: photos} = activity) do
    %Strava.Activity{activity |
      photos: Strava.Activity.Photo.Summary.parse(struct(Strava.Activity.Photo.Summary, photos))
    }
  end

  @spec parse_segment_efforts(Strava.Activity.t) :: Strava.Activity.t
  defp parse_segment_efforts(activity)
  defp parse_segment_efforts(%Strava.Activity{segment_efforts: nil} = activity), do: activity
  defp parse_segment_efforts(%Strava.Activity{segment_efforts: segment_efforts} = activity) do
    %Strava.Activity{activity |
      segment_efforts: Enum.map(segment_efforts, fn segment_effort ->
        Strava.SegmentEffort.parse(struct(Strava.SegmentEffort, segment_effort))
      end)
    }
  end
end
