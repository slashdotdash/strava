defmodule Strava.SegmentEfforts do
  @moduledoc """
  API calls for all endpoints tagged `SegmentEfforts`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  List Segment Efforts

  Returns a set of the authenticated athlete's segment efforts for a given
  segment.

  ## Parameters

  - client (Strava.Client) - Client to make authenticated requests
  - id (integer()) - The identifier of the segment.
  - opts (KeywordList) - [optional] Optional parameters
    - :page (integer()) - Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
    - :start_date_local (date/time encoded as an ISO9601 string) - Restrict
      efforts to after the local start date.
    - :end_date_local (date/time encoded as an ISO9601 string) - Restrict
      efforts to before the local end date.

  Note for start and end local date filtering both values must be provided.

  ## Returns

  {:ok, [%DetailedSegmentEffort{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_efforts_by_segment_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.DetailedSegmentEffort.t())} | {:error, Tesla.Env.t()}
  def get_efforts_by_segment_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query,
      :start_date_local => :query,
      :end_date_local => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/segments/#{id}/all_efforts")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.DetailedSegmentEffort{}])
  end

  @doc """
  Get Segment Effort
  Returns a segment effort from an activity that is owned by the authenticated athlete.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment effort.
  - opts (KeywordList): [optional] Optional parameters

  ## Returns

  {:ok, %Strava.DetailedSegmentEffort{}} on success
  {:error, info} on failure
  """
  @spec get_segment_effort_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedSegmentEffort.t()} | {:error, Tesla.Env.t()}
  def get_segment_effort_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/segment_efforts/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedSegmentEffort{})
  end
end
