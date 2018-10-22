defmodule Strava.UpdatableActivity do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :commute,
    :trainer,
    :description,
    :name,
    :type,
    :gear_id
  ]

  @type t :: %__MODULE__{
          commute: boolean(),
          trainer: boolean(),
          description: String.t(),
          name: String.t(),
          type: ActivityType,
          gear_id: String.t()
        }
end

defimpl Poison.Decoder, for: Strava.UpdatableActivity do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:type, :struct, Strava.ActivityType, options)
  end
end
