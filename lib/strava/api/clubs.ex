defmodule Strava.Clubs do
  @moduledoc """
  API calls for all endpoints tagged `Clubs`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  List Club Activities
  Retrieve recent activities from members of a specific club. The authenticated athlete must belong to the requested club in order to hit this endpoint. Pagination is supported. Athlete profile visibility is respected for all activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the club.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryActivity{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_club_activities_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.SummaryActivity.t())} | {:error, Tesla.Env.t()}
  def get_club_activities_by_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/clubs/#{id}/activities")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryActivity{}])
  end

  @doc """
  List Club Administrators.
  Returns a list of the administrators of a given club.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the club.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryAthlete{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_club_admins_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.SummaryAthlete.t())} | {:error, Tesla.Env.t()}
  def get_club_admins_by_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/clubs/#{id}/admins")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryAthlete{}])
  end

  @doc """
  Get Club
  Returns a given club using its identifier.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the club.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.DetailedClub{}} on success
  {:error, info} on failure
  """
  @spec get_club_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedClub.t()} | {:error, Tesla.Env.t()}
  def get_club_by_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/clubs/#{id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedClub{})
  end

  @doc """
  List Club Members
  Returns a list of the athletes who are members of a given club.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the club.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryAthlete{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_club_members_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.SummaryAthlete.t())} | {:error, Tesla.Env.t()}
  def get_club_members_by_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/clubs/#{id}/members")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryAthlete{}])
  end

  @doc """
  List Athlete Clubs
  Returns a list of the clubs whose membership includes the authenticated athlete.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryClub{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_logged_in_athlete_clubs(Tesla.Env.client(), keyword()) ::
          {:ok, list(Strava.SummaryClub.t())} | {:error, Tesla.Env.t()}
  def get_logged_in_athlete_clubs(client, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/athlete/clubs")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryClub{}])
  end
end
