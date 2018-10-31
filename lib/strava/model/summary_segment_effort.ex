defmodule Strava.SummarySegmentEffort do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :elapsed_time,
    :start_date,
    :start_date_local,
    :distance,
    :is_kom
  ]

  @type t :: %__MODULE__{
          id: integer(),
          elapsed_time: integer(),
          start_date: DateTime.t(),
          start_date_local: DateTime.t(),
          distance: float(),
          is_kom: boolean()
        }
end
