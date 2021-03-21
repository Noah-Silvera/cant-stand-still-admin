## Scraping Ride Data

See [this chart](https://app.lucidchart.com/invitations/accept/9ace1991-399e-442c-b9a2-3c9dbb505814) for how the continuous ride updates work.

### Relevant Jobs

- `RefreshAccessTokenJob`
    - _Queued_: When a new access and refresh token is received.
    - _Task_: Get a new access and refresh token from strava
    - _Success_: Store the new access and refresh token and queue....
        - Another instance of `RefreshAccessTokenJob` for immediately before the access token expires
        - An instance of `RefreshProfileInfoJob`
        - An instance of `FetchRidesJob`
    - _Failure_: set the access token and refresh token to nil and send the user an email informing them their credentials are out of date.

- `FetchRidesJob`
  - _Queued_: When a user first logs in OR on a webhook from strava signaling a new ride has been uploaded
  - _Task_: Retrieved all the rides since the last ride in the DB and force a refresh for the relevant nextjs page
  - _Failure_: Queue a `RefreshAccessTokenJob` and retry up to a maximum of 4 times

- `RefreshProfileInfoJob`
    - _Queued_: by jobs that refresh the access token
    - _Task_: Get new profile info from strava
    - _Success_: Force refresh the nextjs page for that profile
    - _Failure_: Queue the `FailedStravaRequestHandler`
