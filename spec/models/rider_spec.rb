require 'rails_helper'

RSpec.describe Rider, type: :model do
  describe "#create_and_populate_rides" do
    subject { Rider.create_and_populate_rides(attributes_for(:rider)) }

    it "creates a rider" do
      expect { subject }.to change { Rider.count }.from(0).to(1)
    end

    it "queues a refresh access token job" do
      expect(RefreshAccessTokenJob).to receive(:queue_job)
      subject
    end

    it "queues a fetch rides job" do
      subject
      expect(FetchRidesJob).to have_enqueued_sidekiq_job(subject.id)
    end
  end
end
