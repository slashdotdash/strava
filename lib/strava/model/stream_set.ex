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
          time: Strava.TimeStream.t(),
          distance: Strava.DistanceStream.t(),
          latlng: Strava.LatLngStream.t(),
          altitude: Strava.AltitudeStream.t(),
          velocity_smooth: Strava.SmoothVelocityStream.t(),
          heartrate: Strava.HeartrateStream.t(),
          cadence: Strava.CadenceStream.t(),
          watts: Strava.PowerStream.t(),
          temp: Strava.TemperatureStream.t(),
          moving: Strava.MovingStream.t(),
          grade_smooth: Strava.SmoothGradeStream.t()
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
