defmodule Strava.MetaActivity do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id
  ]

  @type t :: %__MODULE__{
          id: integer()
        }
end
