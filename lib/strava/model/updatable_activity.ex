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
          type: String.t(),
          gear_id: String.t()
        }
end
