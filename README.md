### BACKEND

This is the backend of the Cant Stand Still app.
The frontend [is here] (https://github.com/Noah-Silvera/cant-stand-still-frontend)

## Cant Stand Still

This is an application which aims to allow connect and visualize your strava data as trips over a time period. It will allow you to login with Strava, create "trips" that span date ranges, and view those trips as connected rides on a map, along with some stats

## Development Setup

1. Clone the repository
1. Ensure you have the ruby version specified in the .tool-versions file (Also, you should check out [ASDF](https://github.com/asdf-vm/asdf))
3. Run `bin/setup`
4. Run the rails server `bundle exec rails s`
5. Run sidekiq `bundle exec sidekiq

## Running the tests

The specs are written with RSpec, and the whole suite can be run like this

`bundle exec rspec spec`

## Testing with the frontend

This server is meant to be run in [tandem with the frontend](https://github.com/Noah-Silvera/cant-stand-still-frontend)

Follow the instructions in the readme for that project to setup running it against your local server.
