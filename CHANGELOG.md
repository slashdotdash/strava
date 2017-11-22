# Changelog

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
