defmodule Strava.Comment do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :activity_id,
    :text,
    :athlete,
    :created_at
  ]

  @type t :: %__MODULE__{
          id: integer(),
          activity_id: integer(),
          text: String.t(),
          athlete: Strava.SummaryAthlete.t(),
          created_at: DateTime.t()
        }
end

defimpl Poison.Decoder, for: Strava.Comment do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:athlete, :struct, Strava.SummaryAthlete, options)
    |> deserialize(:created_at, :datetime, options)
  end
end
