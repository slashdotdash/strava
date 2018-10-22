defmodule Strava.Segments do
  @moduledoc """
  API calls for all endpoints tagged `Segments`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Explore segments

  Returns the top 10 segments matching a specified query.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - bounds ([float()]): The latitude and longitude for two points describing a
    rectangular boundary for the search: [southwest corner latitutde, southwest
    corner longitude, northeast corner latitude, northeast corner longitude]
  - opts (KeywordList): [optional] Optional parameters
    - :activity_type (String.t): Desired activity type.
    - :min_cat (integer()): The minimum climbing category.
    - :max_cat (integer()): The maximum climbing category.
    
  ## Returns

  {:ok, %Strava.ExplorerResponse{}} on success
  {:error, info} on failure
  """
  @spec explore_segments(Tesla.Env.client(), list(Float.t()), keyword()) ::
          {:ok, Strava.ExplorerResponse.t()} | {:error, Tesla.Env.t()}
  def explore_segments(client, bounds, opts \\ []) do
    optional_params = %{
      :activity_type => :query,
      :min_cat => :query,
      :max_cat => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/segments/explore")
      |> add_param(:query, :bounds, bounds)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.ExplorerResponse{})
  end

  @doc """
  Get Segment Leaderboard

  Returns the specified segment leaderboard.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment leaderboard.
  - opts (KeywordList): [optional] Optional parameters
    - :gender (String.t): Filter by gender.
    - :age_group (String.t): Summit Feature. Filter by age group.
    - :weight_class (String.t): Summit Feature. Filter by weight class.
    - :following (boolean()): Filter by friends of the authenticated athlete.
    - :club_id (integer()): Filter by club.
    - :date_range (String.t): Filter by date range.
    - :context_entries (integer()):
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.

  ## Returns

  {:ok, %Strava.SegmentLeaderboard{}} on success
  {:error, info} on failure
  """
  @spec get_leaderboard_by_segment_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.SegmentLeaderboard.t()} | {:error, Tesla.Env.t()}
  def get_leaderboard_by_segment_id(client, id, opts \\ []) do
    optional_params = %{
      :gender => :query,
      :age_group => :query,
      :weight_class => :query,
      :following => :query,
      :club_id => :query,
      :date_range => :query,
      :context_entries => :query,
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/segments/#{id}/leaderboard")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.SegmentLeaderboard{})
  end

  @doc """
  List Starred Segments

  List of the authenticated athlete's starred segments. Private segments are
  filtered out unless requested by a token with `read_all` scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummarySegment{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_logged_in_athlete_starred_segments(Tesla.Env.client(), keyword()) ::
          {:ok, list(Strava.SummarySegment.t())} | {:error, Tesla.Env.t()}
  def get_logged_in_athlete_starred_segments(client, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/segments/starred")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummarySegment{}])
  end

  @doc """
  Get Segment
  Returns the specified segment.

  `read_all` scope required in order to retrieve athlete-specific segment
  information, or to retrieve private segments.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.DetailedSegment{}} on success
  {:error, info} on failure
  """
  @spec get_segment_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedSegment.t()} | {:error, Tesla.Env.t()}
  def get_segment_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/segments/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedSegment{})
  end

  @doc """
  Star Segment
  Stars/Unstars the given segment for the authenticated athlete.

  Requires `profile:write` scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment to star.
  - starred (boolean()): If true, star the segment; if false, unstar the segment.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.DetailedSegment{}} on success
  {:error, info} on failure
  """
  @spec star_segment(Tesla.Env.client(), integer(), boolean(), keyword()) ::
          {:ok, Strava.DetailedSegment.t()} | {:error, Tesla.Env.t()}
  def star_segment(client, id, starred, _opts \\ []) do
    request =
      %{}
      |> method(:put)
      |> url("/segments/#{id}/starred")
      |> add_param(:form, :starred, starred)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedSegment{})
  end
end
