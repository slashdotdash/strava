# Changelog

## v0.7.0

- Activity retrieve filters ([#24](https://github.com/slashdotdash/strava/pull/24)).
- Average grade should be returned on Segment.explore
([#23](https://github.com/slashdotdash/strava/pull/23)).
- Remove `grant_type` param from OAuth token exchange.

  > On October 15, 2018 the Strava API team will release a refresh token OAuth 2.0 implementation. This date marks the beginning of a migration period during which any requests with a grant_type header will be routed to new authorization logic for refresh tokens, while requests without a grant_type will use the older, existing logic. Both paths will be open for the duration of the migration period, after which the old logic will be deprecated and removed. Rest assured, we will keep both systems working in parallel for a lengthy period.

## v0.6.0

### Enhancements

- Allow `:timeout` and `:recv_timeout` to be configured in environment config for all Strava API requests:

    ```elixir
    config :strava,
      timeout: 8_000,
      recv_timeout: 5_000
    ```

  - `:timeout` - used to establish a connection, in milliseconds (default is 8,000ms).
  - `:recv_timeout` - used when receiving a connection (default is 5,000ms).

## v0.5.0

### Bug fixes

- Fix pagination issue where returned page size is not equal to requested size even when that page is not the last. See the following note from Strava's [pagination](https://strava.github.io/api/#pagination) API documentation:

    > Note that in certain cases, the number of items returned in the response may be lower than the requested page size, even when that page is not the last. If you need to fully go through the full set of results, prefer iterating until an empty page is returned.

## v0.4.1

### Enhancements

- Add Segment Explorer ([#20](https://github.com/slashdotdash/strava/pull/20)).

## v0.4.0

### Enhancements

- [OAuth2 token exchange](https://strava.github.io/api/v3/oauth/#post-token) returns a summary representation of an athlete, instead of a detailed representation (as of [24th July 2017](https://strava.github.io/api/v3/changelog/)).
- Support querying of friends and followers ([#19](https://github.com/slashdotdash/strava/pull/19)).
- Add `Strava.Club.list_activities/3` club activities function ([#18](https://github.com/slashdotdash/strava/pull/18)).
- Add `Strava.Activity.list_athlete_activities/3` ([#15](https://github.com/slashdotdash/strava/pull/15)).

## v0.3.1

### Enhancements

- Add [list starred segment](http://strava.github.io/api/v3/segments/#starred) of the segments starred by the authenticated athlete.
