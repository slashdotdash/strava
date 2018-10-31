defmodule Strava.Streams do
  @moduledoc """
  API calls for all endpoints tagged `Streams`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Get Activity Streams
  Returns the given activity's streams. Requires activity:read scope. Requires activity:read_all scope for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - keys ([String.t]): Desired stream types.
  - key_by_type (boolean()): Must be true.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.StreamSet{}} on success
  {:error, info} on failure
  """
  @spec get_activity_streams(
          Tesla.Env.client(),
          integer(),
          list(String.t()),
          boolean(),
          keyword()
        ) :: {:ok, Strava.StreamSet.t()} | {:error, Tesla.Env.t()}
  def get_activity_streams(client, id, keys, key_by_type, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/streams")
      |> add_param(:query, :keys, keys)
      |> add_param(:query, :key_by_type, key_by_type)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.StreamSet{})
  end

  @doc """
  Get segment effort streams
  Returns a set of streams for a segment effort completed by the authenticated athlete. Requires read_all scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment effort.
  - keys ([String.t]): The types of streams to return.
  - key_by_type (boolean()): Must be true.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.StreamSet{}} on success
  {:error, info} on failure
  """
  @spec get_segment_effort_streams(
          Tesla.Env.client(),
          integer(),
          list(String.t()),
          boolean(),
          keyword()
        ) :: {:ok, Strava.StreamSet.t()} | {:error, Tesla.Env.t()}
  def get_segment_effort_streams(client, id, keys, key_by_type, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/segment_efforts/#{id}/streams")
      |> add_param(:query, :keys, keys)
      |> add_param(:query, :key_by_type, key_by_type)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.StreamSet{})
  end

  @doc """
  Get Segment Streams
  Returns the given segment's streams. Requires read_all scope for private segments.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the segment.
  - keys ([String.t]): The types of streams to return.
  - key_by_type (boolean()): Must be true.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.StreamSet{}} on success
  {:error, info} on failure
  """
  @spec get_segment_streams(Tesla.Env.client(), integer(), list(String.t()), boolean(), keyword()) ::
          {:ok, Strava.StreamSet.t()} | {:error, Tesla.Env.t()}
  def get_segment_streams(client, id, keys, key_by_type, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/segments/#{id}/streams")
      |> add_param(:query, :keys, keys)
      |> add_param(:query, :key_by_type, key_by_type)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.StreamSet{})
  end
end
