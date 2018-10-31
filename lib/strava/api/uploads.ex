defmodule Strava.Uploads do
  @moduledoc """
  API calls for all endpoints tagged `Uploads`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Upload Activity
  Uploads a new data file to create an activity from. Requires activity:write scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - opts (KeywordList): [optional] Optional parameters
    - :file (String.t): The uploaded file.
    - :name (String.t): The desired name of the resulting activity.
    - :description (String.t): The desired description of the resulting activity.
    - :trainer (String.t): Whether the resulting activity should be marked as having been performed on a trainer.
    - :commute (String.t): Whether the resulting activity should be tagged as a commute.
    - :data_type (String.t): The format of the uploaded file.
    - :external_id (String.t): The desired external identifier of the resulting activity.
  ## Returns

  {:ok, %Strava.Upload{}} on success
  {:error, info} on failure
  """
  @spec create_upload(Tesla.Env.client(), keyword()) ::
          {:ok, Strava.Upload.t()} | {:error, Tesla.Env.t()}
  def create_upload(client, opts \\ []) do
    optional_params = %{
      :file => :form,
      :name => :form,
      :description => :form,
      :trainer => :form,
      :commute => :form,
      :data_type => :form,
      :external_id => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/uploads")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.Upload{})
  end

  @doc """
  Get Upload
  Returns an upload for a given identifier. Requires activity:write scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - upload_id (integer()): The identifier of the upload.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Strava.Upload{}} on success
  {:error, info} on failure
  """
  @spec get_upload_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.Upload.t()} | {:error, Tesla.Env.t()}
  def get_upload_by_id(client, upload_id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/uploads/#{upload_id}")
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.Upload{})
  end
end
