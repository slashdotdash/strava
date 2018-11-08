defmodule Strava.Fault do
  @moduledoc """
  Encapsulates the errors that may be returned from the API.
  """

  @derive [Poison.Encoder]
  defstruct [
    :errors,
    :message
  ]

  @type t :: %__MODULE__{
          errors: [Strava.Error.t()],
          message: String.t()
        }
end

defimpl Poison.Decoder, for: Strava.Fault do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:errors, :list, Strava.Error, options)
  end
end
