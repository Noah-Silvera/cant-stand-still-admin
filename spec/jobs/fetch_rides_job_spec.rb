require "rails_helper"
require 'sidekiq/testing'
require 'support/helpers'

RSpec.describe FetchRidesJob, type: :worker do
  include JobHelpers
  include ActiveSupport::Testing::TimeHelpers

  subject { FetchRidesJob.new.perform(rider.id) }

  pages = (1..5).to_a.map { |i|
    File.read(Rails.root.join('spec', 'support', 'data', 'activities', "page-#{i}.json"))
  }

  pages.push("[]")

  total_rides = pages.sum { |page| JSON.parse(page).filter { |activity| activity["type"] == "Ride" }.count }

  context "the rider has no rides" do
    let(:rider) { create :rider }

    it "creates all the rides associated with the rider" do
      freeze_time do
        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
          with(
            query: hash_including({ "before" => Time.zone.now.to_i.to_s }),
            headers: {
          'Accept'=>'application/json; charset=utf-8',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer fake-access-token',
          'User-Agent'=>'Strava Ruby Client/0.4.0'
            }).
          to_return(lambda { |req|
            page_num = req.uri.query_values["page"].to_i - 1
            {
              status: 200,
              body: pages[page_num],
              headers: {
                "content-type" => "application/json; charset=utf-8"
              }
            }
          })

        latest_ride_date = JSON.parse(pages[0]).first["start_date"].to_time.to_i.to_s

        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
        with(
          query: hash_including({ "after" => latest_ride_date}),
          headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer fake-access-token',
            'User-Agent'=>'Strava Ruby Client/0.4.0'
          }).
        to_return(lambda { |req|
          {
            status: 200,
            body: "[]",
            headers: {
              "content-type" => "application/json; charset=utf-8"
            }
          }
        })

        expect { subject }.to change { rider.reload.rides.count }.from(0).to(total_rides)
      end
    end
  end

  context "the rider is missing some older rides" do
    let(:rider) { create :rider }

    it "fetches the older rides" do
      freeze_time do
        ride = create :ride, rider: rider, start_date: Time.zone.now

        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
          with(
            query: hash_including({ "before" => ride.start_date.to_i.to_s }),
            headers: {
          'Accept'=>'application/json; charset=utf-8',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer fake-access-token',
          'User-Agent'=>'Strava Ruby Client/0.4.0'
            }).
          to_return(lambda { |req|
            page_num = req.uri.query_values["page"].to_i - 1
            {
              status: 200,
              body: page_num == 0 ? JSON.dump([JSON.parse(pages[0]).first]) : "[]",
              headers: {
                "content-type" => "application/json; charset=utf-8"
              }
            }
          })

        latest_ride_date = ride.start_date.to_time.to_i.to_s

        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
        with(
          query: hash_including({ "after" => latest_ride_date}),
          headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer fake-access-token',
            'User-Agent'=>'Strava Ruby Client/0.4.0'
          }).
        to_return(lambda { |req|
          {
            status: 200,
            body: "[]",
            headers: {
              "content-type" => "application/json; charset=utf-8"
            }
          }
        })

        expect { subject }.to change { rider.reload.rides.count }.from(1).to(2)
      end
    end
  end

  context "the rider is missing some newer rides" do
    let(:rider) { create :rider }

    it "creates all the rides associated with the rider" do
      freeze_time do
        ride = create :ride, rider: rider, start_date: 1.day.ago

        new_ride = JSON.parse(pages[0]).first
        new_ride["start_date"] = Time.zone.now.iso8601

        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
          with(
            query: hash_including({ "before" => ride.start_date.to_i.to_s }),
            headers: {
          'Accept'=>'application/json; charset=utf-8',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer fake-access-token',
          'User-Agent'=>'Strava Ruby Client/0.4.0'
            }).
          to_return(lambda { |req|
            page_num = req.uri.query_values["page"].to_i - 1
            {
              status: 200,
              body: "[]",
              headers: {
                "content-type" => "application/json; charset=utf-8"
              }
            }
          })

        latest_ride_date = ride.start_date.to_time.to_i.to_s

        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities").
        with(
          query: hash_including({ "after" => latest_ride_date}),
          headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer fake-access-token',
            'User-Agent'=>'Strava Ruby Client/0.4.0'
          }).
        to_return(lambda { |req|
          page_num = req.uri.query_values["page"].to_i - 1
          {
            status: 200,
            body: page_num == 0 ? JSON.dump([new_ride]) : "[]",
            headers: {
              "content-type" => "application/json; charset=utf-8"
            }
          }
        })

        expect { subject }.to change { rider.reload.rides.count }.from(1).to(2)
      end
    end
  end

  context "an authorization error occurs" do
    let(:rider) { create :rider }

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
end
