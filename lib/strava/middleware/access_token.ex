defmodule Strava.Middleware.AccessToken do
  @behaviour Tesla.Middleware

  def call(env, next, access_token) do
    env |> Strava.Client.set_authorization_header(access_token) |> Tesla.run(next)
  end
end
