defmodule Strava.PhotosSummary do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :count,
    :primary
  ]

  @type t :: %__MODULE__{
          count: integer(),
          primary: PhotosSummaryPrimary
        }
end

defimpl Poison.Decoder, for: Strava.PhotosSummary do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:primary, :struct, Strava.PhotosSummaryPrimary, options)
  end
end
