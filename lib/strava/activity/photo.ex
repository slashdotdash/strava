defmodule Strava.Activity.Photo do
  @moduledoc """
  Activity photos are objects associated with an activity. Currently, the only external photo source is Instagram.
  Photos can also be stored on Strava - these photos are referred to as "native".

  More info: https://strava.github.io/api/v3/activity_photos/#photos
  """

  defmodule Summary do
    @type t :: %Strava.Activity.Photo.Summary{
      count: integer,
      primary: Strava.Activity.Photo.Primary.t
    }

    defstruct [
      :count,
      :primary
    ]

    @spec parse(Strava.Activity.Photo.Summary.t) :: Strava.Activity.Photo.Summary.t
    def parse(summary)
    def parse(%Strava.Activity.Photo.Summary{primary: nil} = summary), do: summary
    def parse(%Strava.Activity.Photo.Summary{primary: primary} = summary) do
      %Strava.Activity.Photo.Summary{summary|
        primary: struct(Strava.Activity.Photo.Primary, primary)
      }
    end
  end

  defmodule Primary do
    @type t :: %Strava.Activity.Photo.Primary{
      id: integer,
      source: integer,
      unique_id: String.t,
      urls: map
    }

    defstruct [
      :id,
      :source,
      :unique_id,
      :urls
    ]
  end
end
