defmodule Strava.SummaryGear do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :resource_state,
    :primary,
    :name,
    :distance
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          resource_state: integer(),
          primary: boolean(),
          name: String.t(),
          distance: float()
        }
end
