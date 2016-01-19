defmodule Strava.Segment do
  @moduledoc """
  Segments are specific sections of road. Athletes’ times are compared on these segments and leaderboards are created.
  https://strava.github.io/api/v3/segments/
  """
  @type t :: %Strava.Segment {
    id: Integer.t,
    resource_state: Integer.t,
    name: String.t,
    activity_type: String.t,
    distance: Float.t
  }
  defstruct [
    :id, 
    :resource_state, 
    :name, 
    :activity_type, 
    :distance
  ]

  @doc """
  Retrieve details about a specific segment.
  """
  def retrieve(id) do
    Strava.request("segments/#{id}")
  end
end