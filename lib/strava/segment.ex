defmodule Strava.Segment do
  @moduledoc """
  Segments are specific sections of road. Athletes’ times are compared on these segments and leaderboards are created.
  https://strava.github.io/api/v3/segments/
  """
  @type t :: %Strava.Segment {
    id: number,
    resource_state: number,
    name: String.t,
    activity_type: String.t,
    distance: number,
    average_grade: number,
    maximum_grade: number,
    elevation_high: number,
    elevation_low: number,
    start_latlng: list(number),
    end_latlng: list(number),
    climb_category: number,
    city: String.t,
    state: String.t,
    country: String.t,
    private: boolean,
    starred: boolean,
    created_at: String.t,
    updated_at: String.t,
    total_elevation_gain: number,
    effort_count: number,
    athlete_count: number,
    hazardous: boolean,
    star_count: number
  }
  defstruct [
    :id,
    :resource_state,
    :name,
    :activity_type,
    :distance,
    :average_grade,
    :maximum_grade,
    :elevation_high,
    :elevation_low,
    :start_latlng,
    :end_latlng,
    :climb_category,
    :city,
    :state,
    :country,
    :private,
    :starred,
    :created_at,
    :updated_at,
    :total_elevation_gain,
    :effort_count,
    :athlete_count,
    :hazardous,
    :star_count
  ]

  @doc """
  Retrieve details about a specific segment.
  """
  def retrieve(id) do
    Strava.request("segments/#{id}", as: %Strava.Segment{})
  end
end