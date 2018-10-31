defmodule Strava.TimedZoneDistribution do
  @moduledoc """
  Stores the exclusive ranges representing zones and the time spent in each.
  """

  @derive [Poison.Encoder]
  defstruct []

  @type t :: %__MODULE__{}
end
