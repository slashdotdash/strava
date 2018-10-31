defmodule Strava.Paginator do
  @moduledoc """
  Requests that return multiple items will be paginated to 30 items by default.

  The `page` parameter can be used to specify further pages or offsets.
  The `per_page` parameter may also be used for custom page sizes up to 200.
  """

  @type t :: %__MODULE__{
          per_page: pos_integer,
          page: pos_integer,
          status: atom
        }
  defstruct [:per_page, :page, :status]

  defmodule RequestError do
    defexception message: "paginated request failed"
  end

  @spec stream(
          (keyword() -> {:ok, list} | {:error, term}),
          [{:per_page, pos_integer} | {:first_page, pos_integer}]
        ) :: Enum.t()
  def stream(request, opts \\ [])

  def stream(request, opts) do
    per_page = Keyword.get(opts, :per_page, 200)
    first_page = Keyword.get(opts, :first_page, 1)

    Stream.resource(
      fn -> %Strava.Paginator{per_page: per_page, page: first_page} end,
      &fetch_page(request, &1),
      fn paginator -> paginator end
    )
  end

  defp fetch_page(_request, %Strava.Paginator{status: :halt} = paginator),
    do: {:halt, paginator}

  defp fetch_page(request, %Strava.Paginator{} = paginator) do
    %Strava.Paginator{per_page: per_page, page: page} = paginator

    response = apply(request, [[per_page: per_page, page: page]])

    case response do
      {:error, error} ->
        raise RequestError, message: "paginated request failed with error " <> inspect(error)

      {:ok, []} ->
        # No items, halt pagination
        {:halt, paginator}

      {:ok, items} ->
        # Return items, then request next page
        {items, %Strava.Paginator{paginator | page: page + 1}}
    end
  end
end
