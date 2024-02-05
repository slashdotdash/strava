defmodule Strava.Activities do
  @moduledoc """
  API calls for all endpoints tagged `Activities`.
  """

  alias Strava.Client
  import Strava.RequestBuilder

  @doc """
  Create an Activity
  Creates a manual activity for an athlete, requires activity:write scope.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - name (String.t): The name of the activity.
  - type (String.t): Type of activity. For example - Run, Ride etc.
  - start_date_local (Object): ISO 8601 formatted date time.
  - elapsed_time (integer()): In seconds.
  - opts (KeywordList): [optional] Optional parameters
    - :description (String.t): Description of the activity.
    - :distance (float()): In meters.
    - :trainer (integer()): Set to 1 to mark as a trainer activity.
    - :photo_ids (Object): List of native photo ids to attach to the activity.
    - :commute (integer()): Set to 1 to mark as commute.
  ## Returns

  {:ok, %Strava.DetailedActivity{}} on success
  {:error, info} on failure
  """
  @spec create_activity(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          Strava.Object.t(),
          integer(),
          keyword()
        ) :: {:ok, Strava.DetailedActivity.t()} | {:error, Tesla.Env.t()}
  def create_activity(client, name, type, start_date_local, elapsed_time, opts \\ []) do
    optional_params = %{
      :description => :form,
      :distance => :form,
      :trainer => :form,
      :photo_ids => :form,
      :commute => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/activities")
      |> add_param(:form, :name, name)
      |> add_param(:form, :type, type)
      |> add_param(:form, :start_date_local, start_date_local)
      |> add_param(:form, :elapsed_time, elapsed_time)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedActivity{})
  end

  @doc """
  Get Activity
  Returns the given activity that is owned by the authenticated athlete. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
    - :include_all_efforts (boolean()): To include all segments efforts.
  ## Returns

  {:ok, %Strava.DetailedActivity{}} on success
  {:error, info} on failure
  """
  @spec get_activity_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedActivity.t()} | {:error, Tesla.Env.t()}
  def get_activity_by_id(client, id, opts \\ []) do
    optional_params = %{
      :include_all_efforts => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedActivity{})
  end

  @doc """
  List Activity Comments
  Returns the comments on the given activity. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%Comment{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_comments_by_activity_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.Comment.t())} | {:error, Tesla.Env.t()}
  def get_comments_by_activity_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/comments")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.Comment{}])
  end

  @doc """
  List Activity Kudoers
  Returns the athletes who kudoed an activity identified by an identifier. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryAthlete{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_kudoers_by_activity_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.SummaryAthlete.t())} | {:error, Tesla.Env.t()}
  def get_kudoers_by_activity_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/kudos")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryAthlete{}])
  end

  @doc """
  List Activity Laps
  Returns the laps of an activity identified by an identifier. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, [%Lap{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_laps_by_activity_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.Lap.t())} | {:error, Tesla.Env.t()}
  def get_laps_by_activity_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/laps")
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.Lap{}])
  end

  @doc """
  List Activity Photos
  Returns the photos on the given activity. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
    - :size (integer()): The size of the images to be returned. Defaults to 1024.
  ## Returns

  {:ok, [%PhotoSummary{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_photos_by_activity_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.PhotosSummary.t())} | {:error, Tesla.Env.t()}
  def get_photos_by_activity_id(client, id, opts \\ []) do
    optional_params = %{
      :page => :query,
      :per_page => :query,
      :size => :query
    }
    opts = Keyword.update(opts, :size, 1024, &(&1))

    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/photos")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.Photo{}])
  end

  @doc """
  List Athlete Activities
  Returns the activities of an athlete for a specific identifier. Requires activity:read. Only Me activities will be filtered out unless requested by a token with activity:read_all.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - opts (KeywordList): [optional] Optional parameters
    - :before (integer()): An epoch timestamp to use for filtering activities that have taken place before a certain time.
    - :after (integer()): An epoch timestamp to use for filtering activities that have taken place after a certain time.
    - :page (integer()): Page number.
    - :per_page (integer()): Number of items per page. Defaults to 30.
  ## Returns

  {:ok, [%SummaryActivity{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_logged_in_athlete_activities(Tesla.Env.client(), keyword()) ::
          {:ok, list(Strava.SummaryActivity.t())} | {:error, Tesla.Env.t()}
  def get_logged_in_athlete_activities(client, opts \\ []) do
    optional_params = %{
      :before => :query,
      :after => :query,
      :page => :query,
      :per_page => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/athlete/activities")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.SummaryActivity{}])
  end

  @doc """
  Get Activity Zones
  Summit Feature. Returns the zones of a given activity. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, [%ActivityZone{}, ...]} on success
  {:error, info} on failure
  """
  @spec get_zones_by_activity_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, list(Strava.ActivityZone.t())} | {:error, Tesla.Env.t()}
  def get_zones_by_activity_id(client, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/activities/#{id}/zones")
      |> Enum.into([])

    client |> Client.request(request) |> decode([%Strava.ActivityZone{}])
  end

  @doc """
  Update Activity
  Updates the given activity that is owned by the authenticated athlete. Requires activity:write. Also requires activity:read_all in order to update Only Me activities

  ## Parameters

  - client (Strava.Client): Client to make authenticated requests
  - id (integer()): The identifier of the activity.
  - opts (KeywordList): [optional] Optional parameters
    - :updatable_activity (UpdatableActivity):
  ## Returns

  {:ok, %Strava.DetailedActivity{}} on success
  {:error, info} on failure
  """
  @spec update_activity_by_id(Tesla.Env.client(), integer(), keyword()) ::
          {:ok, Strava.DetailedActivity.t()} | {:error, Tesla.Env.t()}
  def update_activity_by_id(client, id, opts \\ []) do
    optional_params = %{
      :UpdatableActivity => :body
    }

    request =
      %{}
      |> method(:put)
      |> url("/activities/#{id}")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    client |> Client.request(request) |> decode(%Strava.DetailedActivity{})
  end
end
