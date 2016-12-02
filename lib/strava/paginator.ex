defmodule Strava.Paginator do
  @moduledoc """
  Requests that return multiple items will be paginated to 30 items by default.
  The page parameter can be used to specify further pages or offsets. The per_page may also be used for custom page sizes up to 200.

  More info: https://strava.github.io/api/#pagination
  """

  @type t :: %__MODULE__{
    per_page: integer,
    page: integer,
    request_delay: integer,
    status: atom
  }

  defstruct [
    :per_page,
    :page,
    :request_delay,
    :status
  ]

  @spec stream((Strava.Pagination.t -> list), integer, integer, integer) :: Enum.t
  def stream(request, per_page \\ Strava.max_page_size, first_page \\ 1, delay_between_requests_in_milliseconds \\ Strava.delay_between_requests_in_milliseconds) do
    Stream.resource(
      fn -> %Strava.Paginator{per_page: per_page, page: first_page, request_delay: delay_between_requests_in_milliseconds} end,
      fn pagination -> fetch_page(pagination, request) end,
      fn pagination -> pagination end
    )
  end

  defp fetch_page(%Strava.Paginator{status: :halt} = pagination, _request) do {:halt, pagination} end

  defp fetch_page(%Strava.Paginator{per_page: per_page, page: page} = pagination, request) do
    sleep_between_requests(pagination)

    response = apply(request, [%Strava.Pagination{per_page: per_page, page: page}])

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

  @spec sleep_between_requests(Strava.Paginator.t) :: :ok
  defp sleep_between_requests(pagination)
  defp sleep_between_requests(%Strava.Paginator{page: 1}), do: :ok
  defp sleep_between_requests(%Strava.Paginator{request_delay: 0}), do: :ok
  defp sleep_between_requests(%Strava.Paginator{request_delay: delay_between_requests_in_milliseconds}) do
    :timer.sleep(delay_between_requests_in_milliseconds)
  end
end
