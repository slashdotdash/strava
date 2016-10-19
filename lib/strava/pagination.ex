defmodule Strava.Pagination do
  @type t :: %__MODULE__{
    page: integer,
    per_page: integer
  }

  defstruct [
    :page,
    :per_page
  ]
end
