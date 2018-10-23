defmodule Strava.Deserializer do
  @moduledoc """
  Helper functions for deserializing responses into models.
  """

  @doc """
  Update the provided model with a deserialization of a nested value.
  """
  @spec deserialize(
          struct(),
          atom(),
          :list | :struct | :map | :date | :datetime,
          module(),
          map()
        ) :: any()
  def deserialize(model, field, type, mod, options)

  def deserialize(model, field, :list, mod, options) do
    Map.update!(
      model,
      field,
      &Poison.Decode.transform(&1, Map.put(options, :as, [struct(mod)]))
    )
  end

  def deserialize(model, field, :struct, mod, options) do
    Map.update!(
      model,
      field,
      &Poison.Decode.transform(&1, Map.put(options, :as, struct(mod)))
    )
  end

  def deserialize(model, field, :map, mod, options) do
    Map.update!(
      model,
      field,
      &Map.new(&1, fn {key, val} ->
        {key, Poison.Decode.transform(val, Map.put(options, :as, struct(mod)))}
      end)
    )
  end

  def deserialize(model, field, :date, _, _options) do
    with value when is_binary(value) <- Map.get(model, field),
         {:ok, date, _offset} <- Date.from_iso8601(value) do
      Map.put(model, field, date)
    else
      _ -> model
    end
  end

  def deserialize(model, field, :datetime, _options) do
    with value when is_binary(value) <- Map.get(model, field),
         {:ok, datetime, _offset} <- DateTime.from_iso8601(value) do
      Map.put(model, field, datetime)
    else
      _ -> model
    end
  end
end
