defmodule Strava.Photo do
  @moduledoc """
  A photo from a Strava activity
  """

  @derive [Poison.Encoder]
  defstruct [
    :unique_id,
    :athlete_id,
    :activity_name,
    :post_id,
    :resource_state,
    :caption,
    :type,
    :source,
    :status,
    :uploaded_at,
    :created_at,
    :created_at_local,
    :urls,
    :sizes,
    :default_photo
  ]

  @type t :: %__MODULE__{
               unique_id: String.t(),
               athlete_id: integer(),
               activity_name: String.t(),
               post_id: integer(),
               resource_state: integer(),
               caption: String.t(),
               type: integer(),
               source: integer(),
               status: integer(),
               uploaded_at: DateTime.t(),
               created_at: DateTime.t(),
               created_at_local: DateTime.t(),
               urls: %{optional(String.t()) => String.t()},
               sizes: %{optional(String.t()) => [integer()]},
               default_photo: boolean()
             }
end
