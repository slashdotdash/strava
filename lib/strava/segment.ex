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

  ## Example

      Strava.Segment.retrieve(229781)

  More info at: https://strava.github.io/api/v3/segments/#retrieve
  """
  @spec retrieve(number) :: %Strava.Segment{}
  def retrieve(id) do
    Strava.request("segments/#{id}", as: %Strava.Segment{})
  end

  @doc """
  Retrieve an array of segment efforts, for a given segment, filtered by athlete and/or a date range. 

  ## Example

      Strava.Segment.list_efforts(229781)

  More info at: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec retrieve(number) :: [%Strava.Segment{}]
  def list_efforts(id) do
    list_efforts_request(id)
  end

  @doc """
  Retrieve an array of segment efforts, for a given segment, filtered by athlete and/or a date range. 

  ## Example

      Strava.Segment.list_efforts(229781, %{athlete_id: 5287})

  More info at: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec list_efforts(number, map) :: [%Strava.Segment{}]
  def list_efforts(id, filters) do
    list_efforts_request(id, filters)    
  end

  @doc """
  Retrieve an array of segment efforts, for a given segment, filtered by athlete and/or a date range for a given page. 

  ## Example

      Strava.Segment.list_efforts(229781, %{athlete_id: 5287}, %{per_page: 10, page: 1})

  More info at: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec list_efforts(number, map, map) :: [%Strava.Segment{}]
  def list_efforts(id, filters, pagination) do
    list_efforts_request(id, filters, pagination)
  end

  @doc """
  Create a stream of segment efforts, for a given segment, filtered by athlete and/or a date range. 

  ## Example

      Strava.Segment.stream_efforts(229781)

  More info at: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec stream_efforts(number, map) :: Enumerable.t
  def stream_efforts(id, filters \\ %{}) do
    Strava.Paginator.stream(fn(pagination) -> list_efforts(id, filters, pagination) end)
  end

  defp list_efforts_request(id, filters \\ %{}, pagination \\ %{}) do
    Strava.request("segments/#{id}/all_efforts?#{URI.encode_query(Map.merge(filters, pagination))}", as: [%Strava.SegmentEffort{}])
  end
end