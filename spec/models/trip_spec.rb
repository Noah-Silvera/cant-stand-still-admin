require 'rails_helper'

RSpec.describe Trip, type: :model do

  describe "#rides" do
    subject { trip.rides }

    let(:rider) { create :rider }
    let(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: nil}

    let!(:ride_one) { create :ride, rider: rider, start_date: 6.days.ago }
    let!(:ride_two) { create :ride, rider: rider, start_date: 4.days.ago }
    let!(:ride_three) { create :ride, rider: rider, start_date: 1.days.ago }

    it "returns all rides after the start date" do
      expect(subject).to contain_exactly(ride_two, ride_three)
    end

    context "an end date exists" do
      let(:trip) { create :trip, rider: rider, start_date: 5.days.ago, end_date: 2.days.ago}

      it "returns all rides within the trip timeframe" do
        expect(subject).to contain_exactly(ride_two)
      end
    end
  end
end
