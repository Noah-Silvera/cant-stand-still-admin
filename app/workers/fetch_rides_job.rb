require 'sidekiq/api'
require 'ride_factory'

class FetchRidesJob
  include Sidekiq::Worker
  sidekiq_options :retry => 4

  def perform(rider_id)
    if (rider = Rider.find_by id: rider_id)
      client = Strava::Api::Client.new(
        access_token: rider.access_token
      )

      ordered_rides = rider.rides.order(start_date: :asc)

      before = Time.zone.now
      if ordered_rides.present?
        before = ordered_rides.first.start_date.to_time
      end

      client.athlete_activities(before: before) { |activity| process_activity(rider, activity) }

      after = Time.zone.now
      if ordered_rides.reload.present?
        after = ordered_rides.last.start_date.to_time
      end

      client.athlete_activities(after: after) { |activity| process_activity(rider, activity) }
    end
  end

  def process_activity(rider, activity)
    return if activity.type != "Ride"
    return if Ride.find_by("activity_id": activity.id.to_s)

    RideFactory.create!(rider, activity)
  end
end
