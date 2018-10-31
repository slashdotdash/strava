defmodule Strava.MetaClub do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :resource_state,
    :name
  ]

  @type t :: %__MODULE__{
          id: integer(),
          resource_state: integer(),
          name: String.t()
        }
end
