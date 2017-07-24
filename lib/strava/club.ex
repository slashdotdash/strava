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

      club = Strava.Club.retrieve(1)
      club = Strava.Club.retrieve(1, Strava.Client.new("<access_token>>"))

  More info: https://strava.github.io/api/v3/clubs/#get-details
  """
  @spec retrieve(integer, Strava.Client.t) :: Strava.Club.t
  def retrieve(id, client \\ Strava.Client.new) do
    Strava.request("clubs/#{id}", client, as: %Strava.Club{})
  end

  @doc """
  Retrieve the recent activities performed by members of a specific club. The authenticated athlete must be a member of the club.

  ## Example

  club = Strava.Club.list_activities(1, %Strava.Pagination{per_page: 200, page: 1})
  club = Strava.Club.list_activities(1, %Strava.Pagination{per_page: 200, page: 1}, Strava.Client.new("<access_token>>"))

  More info: http://strava.github.io/api/v3/clubs/#get-activities
  """
  @spec list_activities(integer, Strava.Pagination.t, Strava.Client.t) :: list(Strava.Activity.t)
  def list_activities(id, pagination, client \\ Strava.Client.new) do
    "clubs/#{id}/activities?#{URI.encode_query(Map.from_struct(pagination))}"
    |> Strava.request(client, as: [%Strava.Activity{}])
    |> Enum.map(&Strava.Activity.parse/1)
  end

  @doc """
  Retrieve summary information about members of a specific club. Pagination is supported.

  ## Example

      members = Strava.Club.list_members(1, %Strava.Pagination{per_page: 200, page: 1})
      members = Strava.Club.list_members(1, %Strava.Pagination{per_page: 200, page: 1}, Strava.Client.new("<access_token>>"))

  More info: http://strava.github.io/api/v3/clubs/#get-members
  """
  @spec list_members(integer, Strava.Pagination.t, Strava.Client.t) :: list(Strava.Athlete.Summary.t)
  def list_members(id, pagination, client \\ Strava.Client.new) do
    "clubs/#{id}/members?#{URI.encode_query(Map.from_struct(pagination))}"
    |> Strava.request(client, as: [%Strava.Athlete.Summary{}])
    |> Enum.map(&Strava.Athlete.Summary.parse/1)
  end

  @spec stream_members(integer, Strava.Client.t) :: Enumerable.t
  def stream_members(id, client \\ Strava.Client.new) do
    Strava.Paginator.stream(fn pagination -> list_members(id, pagination, client) end)
  end

  defmodule Summary do
    @type t :: %__MODULE__{
      id: integer,
      resource_state: integer,
      name: String.t,
      profile_medium: String.t,
      profile: String.t,
      cover_photo: String.t,
      cover_photo_small: String.t,
      sport_type: String.t,
      city: String.t,
      state: String.t,
      country: String.t,
      private: boolean,
      member_count: integer,
      featured: boolean,
      verified: boolean,
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
      :sport_type,
      :city,
      :state,
      :country,
      :private,
      :member_count,
      :featured,
      :verified,
      :url
    ]
  end
end
