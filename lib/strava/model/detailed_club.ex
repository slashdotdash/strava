defmodule Strava.DetailedClub do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :resource_state,
    :name,
    :profile_medium,
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
    :url,
    :membership,
    :admin,
    :owner,
    :following_count
  ]

  @type t :: %__MODULE__{
          id: integer(),
          resource_state: integer(),
          name: String.t(),
          profile_medium: String.t(),
          cover_photo: String.t(),
          cover_photo_small: String.t(),
          sport_type: String.t(),
          city: String.t(),
          state: String.t(),
          country: String.t(),
          private: boolean(),
          member_count: integer(),
          featured: boolean(),
          verified: boolean(),
          url: String.t(),
          membership: String.t(),
          admin: boolean(),
          owner: boolean(),
          following_count: integer()
        }
end
