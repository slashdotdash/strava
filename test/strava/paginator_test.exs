defmodule Strava.PaginatorTest do
  use ExUnit.Case, async: false

  test "paginate empty list" do
    stream = Strava.Paginator.stream(fn _pagination -> {:ok, []} end)

    assert Enum.to_list(stream) == []
  end

  test "paginate error" do
    stream = Strava.Paginator.stream(fn _pagination -> {:error, :failed} end)

    assert_raise Strava.Paginator.RequestError,
                 "paginated request failed with error :failed",
                 fn ->
                   Stream.run(stream)
                 end
  end

  test "paginate single page" do
    stream =
      Strava.Paginator.stream(
        fn pagination ->
          case Keyword.get(pagination, :page) do
            1 -> {:ok, [1, 2, 3, 4]}
            2 -> {:ok, []}
            _ -> flunk("should not call")
          end
        end,
        per_page: 5
      )

    assert Enum.to_list(stream) == [1, 2, 3, 4]
  end

  test "paginate exactly one page" do
    stream =
      Strava.Paginator.stream(
        fn pagination ->
          case Keyword.get(pagination, :page) do
            1 -> {:ok, [1, 2, 3, 4, 5]}
            2 -> {:ok, []}
            _ -> flunk("should not call")
          end
        end,
        per_page: 5
      )

    assert Enum.to_list(stream) == [1, 2, 3, 4, 5]
  end

  test "paginate two pages" do
    stream =
      Strava.Paginator.stream(
        fn pagination ->
          case Keyword.get(pagination, :page) do
            1 -> {:ok, [1, 2, 3, 4, 5]}
            2 -> {:ok, [6, 7, 8, 9]}
            3 -> {:ok, []}
            _ -> flunk("should not call")
          end
        end,
        per_page: 5
      )

    assert Enum.to_list(stream) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "paginate offset" do
    stream =
      Strava.Paginator.stream(
        fn pagination ->
          case Keyword.get(pagination, :page) do
            2 -> {:ok, [3, 4]}
            3 -> {:ok, [5, 6]}
            4 -> {:ok, [7, 8]}
            5 -> {:ok, []}
            _ -> flunk("should not call")
          end
        end,
        per_page: 2,
        first_page: 2
      )

    assert Enum.to_list(stream) == [3, 4, 5, 6, 7, 8]
  end
end
