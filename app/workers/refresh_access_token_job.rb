require 'sidekiq/api'

class RefreshAccessTokenJob
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  class << self
    def queue_job(rider)
      unless RefreshAccessTokenJob.jobs.any? { |j| Time.at(j["at"]).to_datetime <= (rider.access_token_expires_at - 1.hour) }
        RefreshAccessTokenJob.perform_at(
          rider.access_token_expires_at - 1.hour,
          rider.id
        )
      end
    end
  end

  def perform(rider_id)
    if (rider = Rider.find_by id: rider_id)
      return if rider.refresh_token.nil?

      begin
        client = Strava::OAuth::Client.new(
          client_id: Rails.application.credentials.strava_client_id,
          client_secret: Rails.application.credentials.strava_client_secret
        )

        token = rider.refresh_token
        token[0] = "3"
        response = client.oauth_token(
          refresh_token: token,
          grant_type: 'refresh_token'
        )

        rider.update!(
          access_token: response.access_token,
          refresh_token: response.refresh_token,
          access_token_expires_at: response.expires_at
        )

        RefreshAccessTokenJob.queue_job(rider)
      rescue Strava::Errors::Fault => e
        if e.errors.any? { |error| error["field"] == "refresh_token" && error["code"] == "invalid" }
          rider.update!(access_token: nil, refresh_token: nil)
        else
          raise e
        end
      end
    end
  end
end
