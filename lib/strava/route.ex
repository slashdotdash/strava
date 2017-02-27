defmodule Strava.Route do
  @moduledoc """
  Routes are manually-created paths made up of sections called legs. Currently it is only possible to create routes using the Routebuilder web interface.
  https://strava.github.io/api/v3/routes/
  """

  import Strava.Util, only: [parse_timestamp: 1]

  @type t :: %__MODULE__{
    id: number,
    resource_state: number,
    name: String.t,
    description: String.t,
    athlete: Strava.Athlete.Summary.t,
    distance: float,
    elevation_gain: float,
    map: Strava.Map.t,
    type: number,
    sub_type: number,
    private: boolean,
    starred: boolean,
    timestamp: NaiveDateTime.t,
    segments: list(Strava.Segment.t)
  }

  defstruct [
    :id,
    :resource_state,
    :name,
    :description,
    :athlete,
    :distance,
    :elevation_gain,
    :map,
    :type,
    :sub_type,
    :private,
    :starred,
    :timestamp,
    :segments,
  ]

  @doc """
  Retrieve details about a specific route.

  ## Example

      Strava.Route.retrieve(2751038)

  More info: https://strava.github.io/api/v3/routes/#retrieve
  """
  @spec retrieve(integer, Strava.Client.t) :: Strava.Route.t
  def retrieve(id, client \\ Strava.Client.new) do
    "routes/#{id}"
    |> Strava.request(client, as: %Strava.Route{})
    |> parse
  end

  @doc """
  Lists a specific athlete’s routes. Private routes will only be included if the authenticating user is viewing their own routes and the token has view_private permissions.
  Doesn't support pagination.

  ## Example

      Strava.Segment.list_routes(3920819)

  More info: https://strava.github.io/api/v3/routes/#list
  """
  @spec list_routes(integer, Strava.Client.t) :: list(Strava.Route.t)
  def list_routes(athlete_id, client \\ Strava.Client.new) do
    list_routes_request(athlete_id, client)
  end

  @spec list_routes_request(integer, Strava.Client.t) :: list(Strava.Route.t)
  defp list_routes_request(athlete_id, client) do
    "athletes/#{athlete_id}/routes"
    |> Strava.request(client, as: [%__MODULE__{}])
    |> Enum.map(&parse/1)
  end

  @doc """
  Parse the map and dates in the route
  """
  @spec parse(Strava.Route.t) :: Strava.Route.t
  def parse(%Strava.Route{} = route) do
    route
    |> parse_map
    |> parse_dates
    |> parse_athlete
    |> parse_segments
  end

  @spec parse_map(Strava.Route.t) :: Strava.Route.t
  defp parse_map(%Strava.Route{map: nil} = route), do: route
  defp parse_map(%Strava.Route{map: map} = route) do
    %Strava.Route{route |
      map: struct(Strava.Map, map)
    }
  end

  @spec parse_dates(Strava.Route.t) :: Strava.Route.t
  defp parse_dates(%Strava.Route{timestamp: timestamp} = route) do
    %Strava.Route{route |
      timestamp: parse_timestamp(timestamp),
    }
  end

  @spec parse_athlete(Strava.Route.t) :: Strava.Route.t
  defp parse_athlete(%Strava.Route{athlete: athlete} = route) do
    %Strava.Route{route |
      athlete: struct(Strava.Athlete.Summary, athlete) |> Strava.Athlete.Summary.parse()
    }
  end

  @spec parse_segments(Strava.Route.t) :: Strava.Route.t
  defp parse_segments(%Strava.Route{segments: nil} = route), do: route
  defp parse_segments(%Strava.Route{segments: segments} = route) do
    %Strava.Route{route |
      segments: Enum.map(segments, fn segment ->
        struct(Strava.Segment, segment) |> Strava.Segment.parse()
      end)
    }
  end
end
