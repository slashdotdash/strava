# Changelog

## v0.4.0

### Enhancements

- [OAuth2 token exchange](https://strava.github.io/api/v3/oauth/#post-token) returns a summary representation of an athlete, instead of a detailed representation (as of [24th July 2017](https://strava.github.io/api/v3/changelog/)).
- Support querying of friends and followers ([#19](https://github.com/slashdotdash/strava/pull/19)).
- Add `Strava.Club.list_activities/3` club activities function ([#18](https://github.com/slashdotdash/strava/pull/18)).
- Add `Strava.Activity.list_athlete_activities/3` ([#15](https://github.com/slashdotdash/strava/pull/15)).


## v0.3.1

### Enhancements

- Add [list starred segment](http://strava.github.io/api/v3/segments/#starred) of the segments starred by the authenticated athlete.
