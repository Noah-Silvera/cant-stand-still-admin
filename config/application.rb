require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require "sidekiq"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CantStandStillAdmin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.hosts << "localhost"
    Rails.application.config.hosts << "localhost:3002"

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.active_job.queue_adapter = :sidekiq

    Sidekiq.configure_server do |config|
      config.redis = { url: ENV.fetch("REDIS_URL") { 'redis://localhost:6379/0' }, namespace: "bike_fast" }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: ENV.fetch("REDIS_URL") { 'redis://localhost:6379/0' }, namespace: "bike_fast" }
    end
  end
end
