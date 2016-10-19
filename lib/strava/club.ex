defmodule Strava.Club do
  @moduledoc """
  Clubs represent groups of athletes on Strava.

  More info: https://strava.github.io/api/v3/clubs/
  """

  @type t :: %__MODULE__{
    id: integer,
    resource_state: integer,
    name: String.t,
    profile_medium: String.t,
    profile: String.t,
    cover_photo: String.t,
    cover_photo_small: String.t,
    description: String.t,
    club_type: String.t,
    sport_type: String.t,
    city: String.t,
    state: String.t,
    country: String.t,
    private: boolean,
    member_count: integer,
    featured: boolean,
    verified: boolean,
    membership: String.t,
    admin: boolean,
    owner: boolean,
    following_count: integer,
    url: String.t
  }

  defstruct [
    :id,
    :resource_state,
    :name,
    :profile_medium,
    :profile,
    :cover_photo,
    :cover_photo_small,
    :description,
    :club_type,
    :sport_type,
    :city,
    :state,
    :country,
    :private,
    :member_count,
    :featured,
    :verified,
    :membership,
    :admin,
    :owner,
    :following_count,
    :url
  ]

  @doc """
  Retrieve details about a specific club. The club must be public or the current athlete must be a member.

  ## Example

      Strava.Club.retrieve(1)

  More info at: https://strava.github.io/api/v3/clubs/#get-details
  """
  @spec retrieve(integer) :: Strava.Club.t
  def retrieve(id) do
    Strava.request("clubs/#{id}", as: %Strava.Club{})
  end

  @spec list_members(integer, Strava.Pagination.t) :: list(Strava.Athlete.Summary.t)
  def list_members(id, pagination) do
    "clubs/#{id}/members?#{URI.encode_query(Map.from_struct(pagination))}"
    |> Strava.request(as: [%Strava.Athlete.Summary{}])
    |> Enum.map(&Strava.Athlete.Summary.parse/1)
  end

  @spec stream_members(integer) :: Enumerable.t
  def stream_members(id) do
    Strava.Paginator.stream(fn pagination -> list_members(id, pagination) end)
  end
end
