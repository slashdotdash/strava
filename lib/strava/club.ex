defmodule Strava.Club do
  @moduledoc """
  Clubs represent groups of athletes on Strava.
  
  More info: https://strava.github.io/api/v3/clubs/
  """
  defstruct [
    :id,
    :resource_state,
    :name,
    :profile_medium,
    :profile,
    :description,
    :club_type,
    :sport_type,
    :city,
    :state,
    :country,
    :private,
    :member_count
  ]

  @doc """
  Retrieve details about a specific club. The club must be public or the current athlete must be a member.

  ## Example

      Strava.Club.retrieve(1)

  More info at: https://strava.github.io/api/v3/clubs/#get-details
  """
  @spec retrieve(number) :: %Strava.Club{}
  def retrieve(id) do
    Strava.request("clubs/#{id}", as: %Strava.Club{})
  end
end