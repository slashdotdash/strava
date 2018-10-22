defmodule Strava.Gears do
  @moduledoc """
  API calls for all endpoints tagged `Gears`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Get Equipment
  Returns an equipment using its identifier.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the gear.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.DetailedGear{}} on success
  {:error, info} on failure
  """
  @spec get_gear_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedGear.t()} | {:error, Tesla.Env.t()}
  def get_gear_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/gear/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedGear{})
  end
end
