defmodule Strava.SummaryAthlete do
  @moduledoc """

  """

  @derive [Poison.Encoder]
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
    :summit,
    :created_at,
    :updated_at
  ]

  @type t :: %__MODULE__{
          id: integer(),
          resource_state: integer(),
          firstname: String.t(),
          lastname: String.t(),
          profile_medium: String.t(),
          profile: String.t(),
          city: String.t(),
          state: String.t(),
          country: String.t(),
          sex: String.t(),
          friend: String.t(),
          follower: String.t(),
          premium: boolean(),
          summit: boolean(),
          created_at: DateTime.t(),
          updated_at: DateTime.t()
        }
end
