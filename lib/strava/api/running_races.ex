defmodule Strava.RunningRaces do
  @moduledoc """
  API calls for all endpoints tagged `RunningRaces`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Get Running Race
  Returns a running race for a given identifier.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the running race.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.RunningRace{}} on success
  {:error, info} on failure
  """
  @spec get_running_race_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.RunningRace.t()} | {:error, Tesla.Env.t()}
  def get_running_race_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/running_races/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.RunningRace{})
  end

  @doc """
  List Running Races
  Returns a list running races based on a set of search criteria.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - opts (KeywordList): [optional] Optional parameters
    - :year (integer()): Filters the list by a given year.
  ## Returns

  {:ok, [%RunningRace{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_running_races(Tesla.Env.client(), keyword()) ::
          {:ok, list(Strava.RunningRace.t())} | {:error, Tesla.Env.t()}
  def get_running_races(client, opts \\ []) do
    optional_params = %{
      :year => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/running_races")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.RunningRace{}])
  end
end
