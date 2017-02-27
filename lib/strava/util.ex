defmodule Strava.Util do
  @moduledoc """
  Generic utility functions
  """

  @doc """
  Parses a `String` date into `NaiveDateTime` struct.

  ## Examples

      iex> Strava.Util.parse_date("2012-05-16T21:37:06Z")
      ~N[2012-05-16 21:37:06]
  """
  @spec parse_date(String.t) :: NaiveDateTime.t | String.t
  def parse_date(date)
  def parse_date(nil), do: nil
  def parse_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, date} -> date
      {:error, _} -> date
    end
  end

  @doc """
  Parses an unix timestamp into `NaiveDateTime` struct.

  ## Examples

      iex> Strava.Util.parse_timestamp(1414868960)
      ~N[2014-11-01 19:09:20]
  """
  @spec parse_timestamp(number) :: NaiveDateTime.t
  def parse_timestamp(timestamp)
  def parse_timestamp(nil), do: nil
  def parse_timestamp(timestamp) do
    {:ok, date_time} = DateTime.from_unix(timestamp)
    DateTime.to_naive(date_time)
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
