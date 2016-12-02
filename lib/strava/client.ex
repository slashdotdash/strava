defmodule Strava.Client do
  defstruct [
    access_token: nil,
  ]

  @type t :: %__MODULE__{
    access_token: String.t
  }

  @doc """
  Create a client using the access token from config
  """
  @spec new :: t
  def new(), do: %__MODULE__{access_token: Strava.access_token}

  @doc """
  Create a client using the provided access token
  """
  @spec new(String.t) :: t
  def new(access_token), do: %__MODULE__{access_token: access_token}
end
