require "rails_helper"

RSpec.describe "Trips Controller", type: :request do
  describe "/rides" do
    subject {
      get rider_trip_rides_path(rider, trip, format: :json)
    }
    let(:rider) { create :rider }
    let(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: 1.day.ago }

    let!(:ride_one) { create :ride, rider: rider, start_date: 3.days.ago }
    let!(:ride_two) { create :ride, rider: rider, start_date: 2.days.ago }

    it "returns the rides (with filtered attributes) associated with the trip" do
      subject
      rides_with_sorted_attrs = JSON.parse(response.body).map do |ride|
        ride.sort
      end
      expect(rides_with_sorted_attrs).to contain_exactly(
        JSON.parse(ride_one.to_json(only: Ride.allowed_attributes)).sort,
        JSON.parse(ride_two.to_json(only: Ride.allowed_attributes)).sort
      )
    end
  end
end
