require 'sidekiq/api'
require 'ride_factory'

class FetchRidesJob
  include Sidekiq::Worker
  sidekiq_options :retry => 4

  def perform(trip_id)
    if (trip = Trip.find_by id: trip_id)
      rider = trip.rider
      return if rider.access_token.nil?

      begin
        client = Strava::Api::Client.new(
          access_token: rider.access_token
        )

        if trip.end_date.nil?
          client.athlete_activities(
            after: trip.start_date
          ) { |activity| process_activity(rider, activity) }
        else
          client.athlete_activities(
            after: trip.start_date,
            before: trip.end_date
          ) { |activity| process_activity(rider, activity) }
        end
      rescue Strava::Errors::Fault => e
        RefreshAccessTokenJob.perform_async(rider.id)
        raise e
      end
    end
  end

  def process_activity(rider, activity)
    return if activity.type != "Ride"
    return if Ride.find_by("activity_id": activity.id.to_s)

    RideFactory.create!(rider, activity)
  end
end
