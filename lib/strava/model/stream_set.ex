defmodule Strava.StreamSet do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :time,
    :distance,
    :latlng,
    :altitude,
    :velocity_smooth,
    :heartrate,
    :cadence,
    :watts,
    :temp,
    :moving,
    :grade_smooth
  ]

  @type t :: %__MODULE__{
          time: Strava.TimeStream,
          distance: Strava.DistanceStream,
          latlng: Strava.LatLngStream,
          altitude: Strava.AltitudeStream,
          velocity_smooth: Strava.SmoothVelocityStream,
          heartrate: Strava.HeartrateStream,
          cadence: Strava.CadenceStream,
          watts: Strava.PowerStream,
          temp: Strava.TemperatureStream,
          moving: Strava.MovingStream,
          grade_smooth: Strava.SmoothGradeStream
        }
end

defimpl Poison.Decoder, for: Strava.StreamSet do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:time, :struct, Strava.TimeStream, options)
    |> deserialize(:distance, :struct, Strava.DistanceStream, options)
    |> deserialize(:latlng, :struct, Strava.LatLngStream, options)
    |> deserialize(:altitude, :struct, Strava.AltitudeStream, options)
    |> deserialize(:velocity_smooth, :struct, Strava.SmoothVelocityStream, options)
    |> deserialize(:heartrate, :struct, Strava.HeartrateStream, options)
    |> deserialize(:cadence, :struct, Strava.CadenceStream, options)
    |> deserialize(:watts, :struct, Strava.PowerStream, options)
    |> deserialize(:temp, :struct, Strava.TemperatureStream, options)
    |> deserialize(:moving, :struct, Strava.MovingStream, options)
    |> deserialize(:grade_smooth, :struct, Strava.SmoothGradeStream, options)
  end
end
