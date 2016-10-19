defmodule Strava.Athlete do
  @moduledoc """
  Athletes are Strava users, Strava users are athletes.

  More info: https://strava.github.io/api/v3/athlete/
  """

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
      updated_at: NaiveDateTime.t | String.t
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
      :updated_at
    ]

    def parse(%Strava.Athlete.Summary{} = athlete) do
      athlete
    end
  end

  defmodule Meta do
    @type t :: %__MODULE__{
      id: integer,
      resource_state: integer
    }

    defstruct [
      :id,
      :resource_state
    ]
  end
end
