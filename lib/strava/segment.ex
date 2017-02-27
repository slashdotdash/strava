defmodule Strava.Segment do
  @moduledoc """
  Segments are specific sections of road. Athletes’ times are compared on these segments and leaderboards are created.
  https://strava.github.io/api/v3/segments/
  """

  import Strava.Util, only: [parse_date: 1]

  @type t :: %__MODULE__{
    id: number,
    resource_state: number,
    name: String.t,
    activity_type: String.t,
    distance: number,
    average_grade: float,
    maximum_grade: float,
    elevation_high: float,
    elevation_low: float,
    start_latlng: list(float),
    end_latlng: list(float),
    climb_category: integer,
    city: String.t,
    state: String.t,
    country: String.t,
    private: boolean,
    starred: boolean,
    created_at: NaiveDateTime.t | String.t,
    updated_at: NaiveDateTime.t | String.t,
    total_elevation_gain: float,
    map: Strava.Map.t,
    effort_count: integer,
    athlete_count: integer,
    hazardous: boolean,
    star_count: integer
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
    :map,
    :effort_count,
    :athlete_count,
    :hazardous,
    :star_count
  ]

  @doc """
  Retrieve details about a specific segment.

  ## Example

      Strava.Segment.retrieve(229781)

  More info: https://strava.github.io/api/v3/segments/#retrieve
  """
  @spec retrieve(integer, Strava.Client.t) :: Strava.Segment.t
  def retrieve(id, client \\ Strava.Client.new) do
    "segments/#{id}"
    |> Strava.request(client, as: %Strava.Segment{})
    |> parse
  end

  @doc """
  Retrieve a list the segments starred by the authenticated athlete.

  ## Example

      Strava.Segment.list_starred()

  More info: http://strava.github.io/api/v3/segments/#starred
  """
  @spec list_starred(Strava.Client.t) :: list(Strava.Segment.t)
  def list_starred(client \\ Strava.Client.new) do
    list_starred_request(%Strava.Pagination{}, client)
  end

  @doc """
  Retrieve a list the segments starred by the authenticated athlete, for a given page.

  ## Example

      Strava.Segment.paginate_starred(%Strava.Pagination{per_page: 10, page: 1})

  More info: http://strava.github.io/api/v3/segments/#starred
  """
  @spec paginate_starred(Strava.Pagination.t, Strava.Client.t) :: list(Strava.Segment.t)
  def paginate_starred(pagination, client \\ Strava.Client.new) do
    list_starred_request(pagination, client)
  end

  @doc """
  Create a stream of segments starred by the authenticated athlete.

  ## Example

      Strava.Segment.stream_starred()

  More info: http://strava.github.io/api/v3/segments/#starred
  """
  @spec stream_starred(Strava.Client.t) :: Enum.t
  def stream_starred(client \\ Strava.Client.new) do
    Strava.Paginator.stream(fn pagination -> paginate_starred(pagination, client) end)
  end

  @doc """
  Retrieve a list of segment efforts, for a given segment, optionally filtered by athlete and/or a date range.

  ## Example

      Strava.Segment.list_efforts(229781)
      Strava.Segment.list_efforts(229781, %{athlete_id: 5287})

  More info: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec list_efforts(integer, map, Strava.Client.t) :: list(Strava.SegmentEffort.t)
  def list_efforts(id, filters \\ %{}, client \\ Strava.Client.new) do
    list_efforts_request(id, filters, %Strava.Pagination{}, client)
  end

  @doc """
  Retrieve a list of segment efforts for a given segment, filtered by athlete and/or a date range, for a given page.

  ## Example

      Strava.Segment.paginate_efforts(229781, %{athlete_id: 5287}, %Strava.Pagination{per_page: 10, page: 1})

  More info: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec paginate_efforts(integer, map, Strava.Pagination.t, Strava.Client.t) :: list(Strava.SegmentEffort.t)
  def paginate_efforts(id, filters, pagination, client \\ Strava.Client.new) do
    list_efforts_request(id, filters, pagination, client)
  end

  @doc """
  Create a stream of segment efforts for a given segment, filtered by athlete and/or a date range.

  ## Example

      Strava.Segment.stream_efforts(229781)

  More info: https://strava.github.io/api/v3/segments/#efforts
  """
  @spec stream_efforts(integer, map, Strava.Client.t) :: Enum.t
  def stream_efforts(id, filters \\ %{}, client \\ Strava.Client.new) do
    Strava.Paginator.stream(fn pagination -> paginate_efforts(id, filters, pagination, client) end)
  end

  @spec list_efforts_request(integer, map, Strava.Pagination.t, Strava.Client.t) :: list(Strava.SegmentEffort.t)
  defp list_efforts_request(id, filters, pagination, client) do
    "segments/#{id}/all_efforts?#{query_string(pagination, filters)}"
    |> Strava.request(client, as: [%Strava.SegmentEffort{}])
    |> Enum.map(&Strava.SegmentEffort.parse/1)
  end

  @spec list_starred_request(Strava.Pagination.t, Strava.Client.t) :: list(Strava.Segment.t)
  defp list_starred_request(pagination, client) do
    "segments/starred?#{query_string(pagination)}"
    |> Strava.request(client, as: [%Strava.Segment{}])
    |> Enum.map(&Strava.Segment.parse/1)
  end

  @spec query_string(Strava.Pagination.t, map) :: binary
  defp query_string(pagination, filters \\ %{}) do
    pagination
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(filters)
    |> URI.encode_query
  end

  @doc """
  Parse the map and dates in the segment
  """
  @spec parse(Strava.Segment.t) :: Strava.Segment.t
  def parse(%Strava.Segment{} = segment) do
    segment
    |> parse_map
    |> parse_dates
  end

  @spec parse_map(Strava.Segment.t) :: Strava.Segment.t
  defp parse_map(%Strava.Segment{map: nil} = segment), do: segment
  defp parse_map(%Strava.Segment{map: map} = segment) do
    %Strava.Segment{segment |
      map: struct(Strava.Map, map)
    }
  end

  @spec parse_dates(Strava.Segment.t) :: Strava.Segment.t
  defp parse_dates(%Strava.Segment{created_at: created_at, updated_at: updated_at} = segment) do
    %Strava.Segment{segment |
      created_at: parse_date(created_at),
      updated_at: parse_date(updated_at),
    }
  end
end
