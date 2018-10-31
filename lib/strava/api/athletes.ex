defmodule Strava.Athletes do
  @moduledoc """
  API calls for all endpoints tagged `Athletes`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Get Authenticated Athlete
  Returns the currently authenticated athlete. Tokens with profile:read_all
  scope will receive a detailed athlete representation; all others will receive
  a summary representation.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests

  ## Returns

  {:ok, %Strava.DetailedAthlete{}} on success
  {:error, info} on failure
  """
  @spec get_logged_in_athlete(Tesla.Env.client()) ::
          {:ok, Strava.DetailedAthlete.t()} | {:error, Tesla.Env.t()}
  def get_logged_in_athlete(client) do
    request =
      %{}
      |> method(:get)
      |> url("/athlete")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedAthlete{})
  end

  @doc """
  Get Zones

  Returns the the authenticated athlete's heart rate and power zones.
  Requires `profile:read_all`.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests

  ## Returns

  {:ok, %Strava.Zones{}} on success
  {:error, info} on failure
  """
  @spec get_logged_in_athlete_zones(Tesla.Env.client()) ::
          {:ok, Strava.Zones.t()} | {:error, Tesla.Env.t()}
  def get_logged_in_athlete_zones(client) do
    request =
      %{}
      |> method(:get)
      |> url("/athlete/zones")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.Zones{})
  end

  @doc """
  Get Athlete Stats

  Returns the activity stats of an athlete.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the athlete. Must match the authenticated athlete.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.

  ## Returns

  {:ok, %Strava.ActivityStats{}} on success
  {:error, info} on failure
  """
  @spec get_stats(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.ActivityStats.t()} | {:error, Tesla.Env.t()}
  def get_stats(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/athletes/#{id}/stats")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.ActivityStats{})
  end

  @doc """
  Update Athlete
  Update the currently authenticated athlete. Requires profile:write scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - weight (float()): The weight of the athlete in kilograms.

  ## Returns

  {:ok, %Strava.DetailedAthlete{}} on success
  {:error, info} on failure
  """
  @spec update_logged_in_athlete(Tesla.Env.client(), float()) ::
          {:ok, Strava.DetailedAthlete.t()} | {:error, Tesla.Env.t()}
  def update_logged_in_athlete(client, weight) do
    request =
      %{}
      |> method(:put)
      |> url("/athlete")
      |> add_param(:query, :weight, weight)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedAthlete{})
  end
end
