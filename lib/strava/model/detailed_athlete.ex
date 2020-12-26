defmodule Strava.DetailedAthlete do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :username,
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
    :updated_at,
    :follower_count,
    :friend_count,
    :mutual_friend_count,
    :measurement_preference,
    :email,
    :ftp,
    :weight,
    :clubs,
    :bikes,
    :shoes
  ]

  @type t :: %__MODULE__{
          id: integer(),
          username: String.t(),
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
          updated_at: DateTime.t(),
          follower_count: integer(),
          friend_count: integer(),
          mutual_friend_count: integer(),
          measurement_preference: String.t(),
          email: String.t(),
          ftp: integer(),
          weight: float(),
          clubs: [Strava.SummaryClub.t()],
          bikes: [Strava.SummaryGear.t()],
          shoes: [Strava.SummaryGear.t()]
        }
end

defimpl Poison.Decoder, for: Strava.DetailedAthlete do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:created_at, :datetime, options)
    |> deserialize(:updated_at, :datetime, options)
    |> deserialize(:clubs, :list, Strava.SummaryClub, options)
    |> deserialize(:bikes, :list, Strava.SummaryGear, options)
    |> deserialize(:shoes, :list, Strava.SummaryGear, options)
  end
end
