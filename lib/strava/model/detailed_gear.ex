defmodule Strava.DetailedGear do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :resource_state,
    :primary,
    :name,
    :distance,
    :brand_name,
    :model_name,
    :frame_type,
    :description
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          resource_state: integer(),
          primary: boolean(),
          name: String.t(),
          distance: float(),
          brand_name: String.t(),
          model_name: String.t(),
          frame_type: integer(),
          description: String.t()
        }
end
