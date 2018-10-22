defmodule Strava.SegmentLeaderboard do
  @moduledoc """
  A
  """

  @derive [Poison.Encoder]
  defstruct [
    :entry_count,
    :effort_count,
    :kom_type,
    :entries
  ]

  @type t :: %__MODULE__{
          entry_count: integer(),
          effort_count: integer(),
          kom_type: String.t(),
          entries: [SegmentLeaderboardEntry]
        }
end

defimpl Poison.Decoder, for: Strava.SegmentLeaderboard do
  import Strava.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:entries, :list, Strava.SegmentLeaderboardEntry, options)
  end
end
