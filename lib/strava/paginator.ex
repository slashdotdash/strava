defmodule Strava.Paginator do
  @moduledoc """
  Requests that return multiple items will be paginated to 30 items by default.
  The page parameter can be used to specify further pages or offsets. The per_page may also be used for custom page sizes up to 200.

  More info: https://strava.github.io/api/#pagination
  """
  
  defstruct [
    :per_page,
    :page,
    :status
  ]

  def stream(request, per_page \\ Strava.max_page_size(), first_page \\ 1) do
    Stream.resource(
      fn -> %Strava.Paginator{per_page: per_page, page: first_page} end,
      fn pagination -> fetch_page(pagination, request) end,
      fn pagination -> pagination end
    )
  end

  defp fetch_page(%Strava.Paginator{status: :halt} = pagination, _) do {:halt, pagination} end

  defp fetch_page(%Strava.Paginator{per_page: per_page, page: page} = pagination, request) do
    response = request.(%{per_page: per_page, page: page})
    
    case length(response) do
      ^per_page ->
        # return response, then request next page
        {response, %{pagination | page: page + 1}}
      0 ->
        # no items
        {:halt, pagination}
      _ ->
        # return response, then halt
        {response, %{pagination | status: :halt}}
    end
  end
end