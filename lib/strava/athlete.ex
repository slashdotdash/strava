defmodule Strava.Athlete do
  @moduledoc """
  Athletes are Strava users, Strava users are athletes.

  More info: https://strava.github.io/api/v3/athlete/
  """

  defmodule Summary do
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
  end

  defmodule Meta do
    @type t :: %Strava.Athlete.Meta {
      id: integer,
      resource_state: integer
    }

    defstruct [
      :id,
      :resource_state
    ]
  end
end
