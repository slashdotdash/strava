defmodule Strava.ExplorerResponse do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :segments
  ]

  @type t :: %__MODULE__{
          segments: [Strava.ExplorerSegment.t()]
        }
end

defimpl Poison.Decoder, for: Strava.ExplorerResponse do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:segments, :list, Strava.ExplorerSegment, options)
  end
end
