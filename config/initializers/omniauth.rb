Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    provider :developer,
    :fields => [:user_id],
    :uid_field => :user_id
  end
end

OmniAuth.config.allowed_request_methods = [:get, :post]
