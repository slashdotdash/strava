defmodule Strava do
  use Application
  use HTTPoison.Base

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Strava.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Strava.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Creates the URL for the Strava API V3.
  Args:
    * endpoint - part of the API we're hitting
  Returns string
  """
  def process_url(endpoint) do
    "https://www.strava.com/api/v3/#{endpoint}?access_token=#{access_token}" 
  end

  @doc """
  Converts the binary keys in our response to atoms.
  Args:
    * body - string binary response
  Returns Record or ArgumentError
  """
  def process_response_body(body) do
    JSX.decode!(body, [{:labels, :atom}])
  end

  @doc """
  Boilerplate code to make requests.
  Args:
    * endpoint - string requested API endpoint
    * body - request body
  Returns dict
  """
  def request(endpoint, body \\ []) do
    # Strava.get!(endpoint, JSX.encode! body).body

    Strava.get!(endpoint).body
  end

  @doc """
  Gets the Strava API access token from :strava, :access_token application env or STRAVA_ACCESS_TOKEN from system ENV
  Any registered Strava user can obtain an access_token by first creating an application at https://strava.com/developers
  Returns binary
  """
  def access_token do
    Application.get_env(:strava, :access_token) || System.get_env("STRAVA_ACCESS_TOKEN")
  end
end