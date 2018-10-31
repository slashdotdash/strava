defmodule Strava.PhotosSummaryPrimary do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :urls,
    :unique_id,
    :id,
    :source
  ]

  @type t :: %__MODULE__{
          urls: %{optional(String.t()) => String.t()},
          unique_id: String.t(),
          id: integer(),
          source: integer()
        }
end
