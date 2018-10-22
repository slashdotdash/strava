defmodule Strava.RouteDirection do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :distance,
    :action,
    :name
  ]

  @type t :: %__MODULE__{
          distance: float(),
          action: integer(),
          name: String.t()
        }
end
