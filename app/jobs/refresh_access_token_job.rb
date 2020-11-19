require 'sidekiq/api'

class RefreshAccessTokenJob < ApplicationJob
  queue_as :default

  def perform(rider_id)
    if (rider = Rider.find_by id: rider_id)
      client = Strava::OAuth::Client.new(
        client_id: "22020",
        client_secret: Rails.application.credentials.strava_client_secret
      )
      response = client.oauth_token(
        refresh_token: rider.refresh_token,
        grant_type: 'refresh_token'
      )

      rider.update!(access_token: response.access_token, refresh_token: response.refresh_token)

      unless RefreshAccessTokenJob.queue_adapter.enqueued_jobs.any? { |j| Time.at(j[:at]).to_datetime <= (response.expires_at - 1.hour) }
        RefreshAccessTokenJob.set(wait_until: response.expires_at - 1.hour).perform_later(rider_id)
      end
    end
  end
end
