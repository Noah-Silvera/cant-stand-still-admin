require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Strava < OmniAuth::Strategies::OAuth2
      option :name, "strava"

      option :client_options, {
        site: "https://strava.com"
      }

      option :authorize_params, {
        response_type: "code"
      }

      uid { raw_info.params["athlete"]["id"] }

      info do
        {
          access_token: raw_info.token,
          refresh_token: raw_info.refresh_token,
          expires_at: raw_info.expires_in.seconds.from_now,
          athlete_json: raw_info.params["athlete"]
        }
      end

      def raw_info
        access_token
      end
    end
  end
end
