defmodule Strava.Paginator do
  @moduledoc """
  Requests that return multiple items will be paginated to 30 items by default.
  The page parameter can be used to specify further pages or offsets. The per_page may also be used for custom page sizes up to 200.

  More info: https://strava.github.io/api/#pagination
  """
  
  defstruct [
    :per_page,
    :page,
    :request_delay,
    :status
  ]

  def stream(request, per_page \\ Strava.max_page_size(), first_page \\ 1, delay_between_requests_in_milliseconds \\ 1_000) do
    Stream.resource(
      fn -> %Strava.Paginator{per_page: per_page, page: first_page, request_delay: delay_between_requests_in_milliseconds} end,
      fn pagination -> fetch_page(pagination, request) end,
      fn pagination -> pagination end
    )
  end

  defp fetch_page(%Strava.Paginator{status: :halt} = pagination, _) do {:halt, pagination} end

  defp fetch_page(%Strava.Paginator{per_page: per_page, page: page} = pagination, request) do
    sleep_between_requests(pagination)

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

  defp sleep_between_requests(%Strava.Paginator{page: 1}) do
    # no sleep
  end

  defp sleep_between_requests(%Strava.Paginator{request_delay: delay_between_requests_in_milliseconds}) do      
      :timer.sleep(delay_between_requests_in_milliseconds)
  end
end
