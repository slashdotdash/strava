defmodule Strava.Routes do
  @moduledoc """
  API calls for all endpoints tagged `Routes`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Export Route GPX
  Returns a GPX file of the route. Requires read_all scope for private routes.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the route.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %{}} on success
  {:error, info} on failure
  """
  @spec get_route_as_gpx(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, nil} | {:error, Tesla.Env.t()}
  def get_route_as_gpx(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/routes/#{id}/export_gpx")
      |> Enum.into([])

    client |> Client.request(request) |> decode(false)
  end

  @doc """
  Export Route TCX
  Returns a TCX file of the route. Requires read_all scope for private routes.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the route.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %{}} on success
  {:error, info} on failure
  """
  @spec get_route_as_tcx(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, nil} | {:error, Tesla.Env.t()}
  def get_route_as_tcx(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/routes/#{id}/export_tcx")
      |> Enum.into([])

    client |> Client.request(request) |> decode(false)
  end

  @doc """
  Get Route
  Returns a route using its identifier. Requires read_all scope for private routes.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the route.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.Route{}} on success
  {:error, info} on failure
  """
  @spec get_route_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.Route.t()} | {:error, Tesla.Env.t()}
  def get_route_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/routes/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.Route{})
  end

  @doc """
  List Athlete Routes
  Returns a list of the routes created by the authenticated athlete using their athlete ID. Private routes are filtered out unless requested by a token with read_all scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the athlete.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%Route{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_routes_by_athlete_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.Route.t())} | {:error, Tesla.Env.t()}
  def get_routes_by_athlete_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/athletes/#{id}/routes")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.Route{}])
  end
end
