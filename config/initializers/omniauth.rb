require "strategies/strava"

Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    provider :developer,
    :fields => [:user_id],
    :uid_field => :user_id
  end

  provider :strava, Rails.application.credentials.strava_client_id, Rails.application.credentials.strava_client_secret
end

OmniAuth.config.allowed_request_methods = [:get, :post]
