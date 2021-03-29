require "rails_helper"
require 'sidekiq/testing'
require 'support/helpers'

RSpec.describe FetchRidesJob, type: :worker do
  include JobHelpers
  include ActiveSupport::Testing::TimeHelpers

  subject { FetchRidesJob.new.perform(trip.id) }

  context "the rider and request is valid" do
    let(:rider) { create :rider }
    let!(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: 2.day.ago }

    before do
      stub_request(:get, "https://www.strava.com/api/v3/athlete/activities")
        .with(
          query: hash_including({
            "after" => trip.start_date.to_i.to_s,
            "before" => trip.end_date.to_i.to_s,
          }),
          headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer fake-access-token',
            'User-Agent'=>'Strava Ruby Client/0.4.0'
          }
        ).to_return(lambda { |req|
          page_num = req.uri.query_values["page"].to_i
          if page_num == 1
            {
              status: 200,
              body: JSON.dump([
                {
                  "type": "Ride",
                  "id": 1,
                  "start_date": 4.days.ago.iso8601
                },
                {
                  "type": "Ride",
                  "id": 2,
                  "start_date": 3.days.ago.iso8601
                }
              ]),
              headers: {
                "content-type" => "application/json; charset=utf-8"
              }
            }
          else
            {
              status: 200,
              body: JSON.dump([]),
              headers: {
                "content-type" => "application/json; charset=utf-8"
              }
            }
          end
        })
    end

    context "the trip has no rides" do
      it "creates all the rides associated with the trip" do
        expect { subject }.to change { trip.rides.count }.from(0).to(2)
      end
    end

    context "the trip is missing some rides" do
      let!(:ride_one) { create :ride, activity_id: 1, rider: rider, start_date: 4.days.ago }

      it "fetches and creates the newer rides" do
        expect { subject }.to change { trip.rides.count }.from(1).to(2)
      end
    end

    context "the trip has no end date" do
      let!(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: nil }

      before do
        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities")
          .with(
            query: hash_including({
              "after" => trip.start_date.to_i.to_s
            }),
            headers: {
              'Accept'=>'application/json; charset=utf-8',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization'=>'Bearer fake-access-token',
              'User-Agent'=>'Strava Ruby Client/0.4.0'
            }
          ).to_return(lambda { |req|
            page_num = req.uri.query_values["page"].to_i
            if page_num == 1
              {
                status: 200,
                body: JSON.dump([
                  {
                    "type": "Ride",
                    "id": 1,
                    "start_date": 4.days.ago.iso8601
                  },
                  {
                    "type": "Ride",
                    "id": 2,
                    "start_date": 3.days.ago.iso8601
                  }
                ]),
                headers: {
                  "content-type" => "application/json; charset=utf-8"
                }
              }
            else
              {
                status: 200,
                body: JSON.dump([]),
                headers: {
                  "content-type" => "application/json; charset=utf-8"
                }
              }
            end
          })
      end

      it "creates all the rides associated with the trip" do
        expect { subject }.to change { trip.rides.count }.from(0).to(2)
      end
    end
  end

  context "an authorization error occurs" do
    let(:rider) { create :rider }
    let!(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: 2.day.ago }

    before do
      stub_request(:get, "https://www.strava.com/api/v3/athlete/activities")
        .with(
          query: hash_including({}),
          headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer fake-access-token',
            'User-Agent'=>'Strava Ruby Client/0.4.0'
          }
        ).to_return(lambda { |req|
          {
            status: 401,
            body: ""
          }
        })
    end

    it "queues a RefreshAccessTokenJob then re-raises the error" do
      expect { subject }.to raise_error
      expect(RefreshAccessTokenJob).to have_enqueued_sidekiq_job(rider.id)
    end
  end

  context "a rider does not have an access token" do
    let(:rider) { create :rider, access_token: nil }
    let!(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: 2.day.ago }

    it "exits the job early" do
      expect(subject).to be_nil
    end
  end

  context "the trip does not exist" do
    subject { FetchRidesJob.new.perform(100000) }

    it "exits the job early" do
      expect(subject).to be_nil
    end
  end
end
