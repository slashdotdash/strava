defmodule Strava.Error do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :code,
    :field,
    :resource
  ]

  @type t :: %__MODULE__{
          code: String.t(),
          field: String.t(),
          resource: String.t()
        }
end
