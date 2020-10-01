## Scraping Ride Data

See [this chart](https://app.lucidchart.com/invitations/accept/9ace1991-399e-442c-b9a2-3c9dbb505814) for how the continuous ride updates work.

### Relevant Jobs

- `RefreshAccessTokenJob`
    - _Queued_: When a new access and refresh token is received.
    - _Task_: Get a new access and refresh token from strava
    - _Success_: Store the new access and refresh token and queue....
        - Another instance of `RefreshAccessTokenJob`
        - An instance of `RefreshProfileInfoJob`
        - An instance of `GetLatestRidesJob`
    - _Failure_: Queue the `FailedStravaRequestHandler`.

- `GetLatestRidesJob`
  - _Queued_: When a new access and refresh token is received, **OR** every X minutes.
  - _Task_: Retrieved all the rides since the last ride in the DB.
    - _if_: no new rides are available.
      - Queue another `GetLatestRidesJob` in X minutes.
    - _else_: store the new rides in the DB and queue another `GetLatestRidesJob` now and force refresh nextjs.
  - _Failure_: Queue the `FailedStravaRequestHandler`

- `RefreshProfileInfoJob`
    - _Queued_: by jobs that refresh the access token
    - _Task_: Get new profile info from strava
    - _Success_: Force refresh the nextjs page for that profile
    - _Failure_: Queue the `FailedStravaRequestHandler`

- `FailedStravaRequestHandler`
    - _Queued_: When a request to strava fails.
    - _if_ the failure is a token error: Queue a `NotifyUserJob`.
    - _if_ the failure is an unknown error: Send a retry message up to X times.
    - _else_ Log an unknown error.
    <!-- TODO - this might not have to be a job... -->

- `NotifyUserJob`
    - TODO
