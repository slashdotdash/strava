defmodule Strava.PaginatorTest do
  use ExUnit.Case, async: false

  doctest Strava.Paginator

  test "paginate empty list" do
    stream = Strava.Paginator.stream(fn _ -> [] end)

    assert stream != nil
    assert Enum.to_list(stream) == []
  end

  test "paginate single page" do
    stream = Strava.Paginator.stream(fn pagination ->
      case pagination do
        %{page: 1} -> [1, 2, 3, 4]
        _ -> raise "should not call"
        end
    end, 5)

    assert stream != nil
    assert Enum.to_list(stream) == [1, 2, 3, 4]
  end

  test "paginate exactly one page" do
    stream = Strava.Paginator.stream(fn pagination ->
      case pagination do
        %{page: 1} -> [1, 2, 3, 4, 5]
        _  -> []
        end
    end, 5)

    assert stream != nil
    assert Enum.to_list(stream) == [1, 2, 3, 4, 5]
  end

  test "paginate two pages" do
    stream = Strava.Paginator.stream(fn pagination ->
      case pagination do
        %{page: 1} -> [1, 2, 3, 4, 5]
        %{page: 2} -> [6, 7, 8, 9]
        _ -> raise "should not call"
        end
    end, 5)

    assert stream != nil
    assert Enum.to_list(stream) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end
