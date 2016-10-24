defmodule Strava.Util do
  @moduledoc """
  Generic utility functions
  """

  @doc """
  Parses a `String` date into `NativeDateTime` struct.

  ## Examples

      iex> Strava.Util.parse_date("2012-05-16T21:37:06Z")
      ~N[2012-05-16 21:37:06]
  """
  @spec parse_date(String.t) :: NativeDateTime.t | String.t
  def parse_date(date)
  def parse_date(nil), do: nil
  def parse_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, date} -> date
      {:error, _} -> date
    end
  end

  @spec struct_from_map(map, term) :: struct
  def struct_from_map(map, destination) do
    map = for {key, val} <- map, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_atom(key), val}
      end
    end

    struct(destination, map)
  end
end
