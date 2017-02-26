defmodule Strava.Athlete do
  @moduledoc """
  Athletes are Strava users, Strava users are athletes.

  More info: https://strava.github.io/api/v3/athlete/
  """

  import Strava.Util, only: [parse_date: 1, struct_from_map: 2]

  @type t :: %__MODULE__{
    id: integer,
    resource_state: integer,
    firstname: String.t,
    lastname: String.t,
    profile_medium: String.t,
    profile: String.t,
    city: String.t,
    state: String.t,
    country: String.t,
    sex: String.t,
    friend: String.t,
    follower: String.t,
    premium: boolean,
    created_at: NaiveDateTime.t | String.t,
    updated_at: NaiveDateTime.t | String.t,
    follower_count: integer,
    friend_count: integer,
    mutual_friend_count: integer,
    athlete_type: String.t,
    date_preference: String.t,
    measurement_preference: String.t,
    email: String.t,
    ftp: integer,
    weight: float,
    clubs: list(Strava.Club.Summary.t),
    bikes: list(map),
    shoes: list(map),
  }

  defstruct [
    :id,
    :resource_state,
    :firstname,
    :lastname,
    :profile_medium,
    :profile,
    :city,
    :state,
    :country,
    :sex,
    :friend,
    :follower,
    :premium,
    :created_at,
    :updated_at,
    :follower_count,
    :friend_count,
    :mutual_friend_count,
    :athlete_type,
    :date_preference,
    :measurement_preference,
    :email,
    :ftp,
    :weight,
    :clubs,
    :bikes,
    :shoes,
  ]

  @doc """
  Retrieve details about the current athlete.

  ## Example

      Strava.Athlete.retrieve_current()

  More info: http://strava.github.io/api/v3/athlete/#get-details
  """
  @spec retrieve_current :: Strava.Athlete.t
  def retrieve_current(client \\ Strava.Client.new) do
    "athlete"
    |> Strava.request(client, as: %Strava.Athlete{})
    |> parse
  end

  @doc """
  Retrieve details about an athlete by ID.

  ## Example

      Strava.Athlete.retrieve(5324239)

  More info: http://strava.github.io/api/v3/athlete/#get-another-details
  """
  @spec retrieve(integer) :: Strava.Athlete.t
  def retrieve(id, client \\ Strava.Client.new) do
    "athletes/#{id}"
    |> Strava.request(client, as: %Strava.Athlete{})
    |> parse
  end

  @doc """
  Retrieve an athlete's totals and stats.

  ## Example

      Strava.Athlete.stats(5324239)

  More info: http://strava.github.io/api/v3/athlete/#stats
  """
  @spec stats(integer) :: Strava.Athlete.Stats.t
  def stats(id, client \\ Strava.Client.new) do
    "athletes/#{id}/stats"
    |> Strava.request(client, as: %Strava.Athlete.Stats{})
    |> Strava.Athlete.Stats.parse
  end

  @spec parse(Strava.Athlete.t) :: Strava.Athlete.t
  def parse(%Strava.Athlete{} = athlete) do
    athlete
    |> parse_dates
    |> parse_clubs
  end

  @spec parse_dates(Strava.Athlete.t) :: Strava.Athlete.t
  defp parse_dates(%Strava.Athlete{created_at: created_at, updated_at: updated_at} = athlete) do
    %Strava.Athlete{athlete |
      created_at: parse_date(created_at),
      updated_at: parse_date(updated_at),
    }
  end

  @spec parse_clubs(Strava.Athlete.t) :: Strava.Athlete.t
  defp parse_clubs(%Strava.Athlete{clubs: clubs} = athlete) do
    %Strava.Athlete{athlete |
      clubs: Enum.map(clubs, fn club -> struct_from_map(club, Strava.Club.Summary) end),
    }
  end

  defmodule Summary do
    @type t :: %__MODULE__{
      id: integer,
      resource_state: integer,
      firstname: String.t,
      lastname: String.t,
      profile_medium: String.t,
      profile: String.t,
      city: String.t,
      state: String.t,
      country: String.t,
      sex: String.t,
      friend: String.t,
      follower: String.t,
      premium: boolean,
      created_at: NaiveDateTime.t | String.t,
      updated_at: NaiveDateTime.t | String.t,
    }

    defstruct [
      :id,
      :resource_state,
      :firstname,
      :lastname,
      :profile_medium,
      :profile,
      :city,
      :state,
      :country,
      :sex,
      :friend,
      :follower,
      :premium,
      :created_at,
      :updated_at,
    ]

    @spec parse(Strava.Athlete.Summary.t) :: Strava.Athlete.Summary.t
    def parse(%Strava.Athlete.Summary{} = athlete) do
      athlete
      |> parse_dates
    end

    @spec parse_dates(Strava.Athlete.Summary.t) :: Strava.Athlete.Summary.t
    defp parse_dates(%Strava.Athlete.Summary{created_at: created_at, updated_at: updated_at} = athlete) do
      %Strava.Athlete.Summary{athlete |
        created_at: parse_date(created_at),
        updated_at: parse_date(updated_at),
      }
    end
  end

  defmodule Meta do
    @type t :: %__MODULE__{
      id: integer,
      resource_state: integer,
    }

    defstruct [
      :id,
      :resource_state,
    ]
  end
end
