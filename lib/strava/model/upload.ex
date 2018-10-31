defmodule Strava.Upload do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :external_id,
    :error,
    :status,
    :activity_id
  ]

  @type t :: %__MODULE__{
          id: integer(),
          external_id: String.t(),
          error: String.t(),
          status: String.t(),
          activity_id: integer()
        }
end
