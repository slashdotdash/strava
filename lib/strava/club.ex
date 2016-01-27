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
  def retrieve(id) do
    Strava.request("clubs/#{id}", as: %Strava.Club{})
  end

  def list_members(id, pagination) do
    Strava.request("clubs/#{id}/members?#{URI.encode_query(pagination)}", as: [%Strava.Athlete.Summary{}])
  end

  def stream_members(id) do
    Strava.Paginator.stream(fn(pagination) -> list_members(id, pagination) end)
  end
end