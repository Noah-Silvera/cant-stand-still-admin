require "rails_helper"
require 'sidekiq/testing'
require 'support/helpers'

RSpec.describe RefreshAccessTokenJob, type: :worker do
  include JobHelpers
  include ActiveSupport::Testing::TimeHelpers

  subject { RefreshAccessTokenJob.new.perform(rider.id) }

  let(:rider) { create :rider }

  around { |example| freeze_time { example.run } }

  before do
    stub_request(:post, "https://www.strava.com/oauth/token")
      .to_return(
        status: 200,
        body: {
          "token_type": "Bearer",
          "access_token": "73473823",
          "expires_at": 21600.seconds.from_now.to_time.to_i,
          "expires_in": 21600,
          "refresh_token": "239878237"
        }.to_json,
        headers: {
          "date": "Wed, 04 Nov 2020 04:45:47 GMT",
          "content-type": "application/json; charset=utf-8",
          "cache-control": "max-age=0, private, must-revalidate",
          "via": "1.1 linkerd",
          "x-download-options": "noopen",
          "status": "200 OK",
          "content-encoding": "gzip",
          "x-request-id": "e3e81865-1acf-4a92-9d20-b058de83b60f",
          "referrer-policy": "strict-origin-when-cross-origin",
          "etag": "W/\"2d11b08689dad5ac0bcf8fc30301b0f5\"",
          "x-frame-options": "DENY",
          "x-content-type-options": "nosniff",
          "x-permitted-cross-domain-policies": "none",
          "vary": "Origin",
          "x-xss-protection": "1; mode=block"
        }
      )
  end

  it "updates the access token" do
    expect { subject }.to change { rider.reload.access_token }
  end

  it "enqueues another job an hour before token expiration" do
    subject
    expect(RefreshAccessTokenJob).to have_enqueued_sidekiq_job(rider.id).at(5.hours.from_now)
  end

  context "there is another another refresh job enqueued before the expiration of the token" do
    before do
      RefreshAccessTokenJob.perform_at(1.hour.from_now)
    end

    it "does not enqueue another job" do
      expect { subject }.not_to have_enqueued_job(RefreshAccessTokenJob)
    end
  end
end
