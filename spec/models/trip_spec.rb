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

  describe "#create_and_populate_rides!" do
    subject { Trip.create_and_populate_rides!(rider, attributes_for(:trip)) }

    let(:rider) { create :rider }

    it "creates the trip" do
      expect { subject }.to change { Trip.count }.from(0).to(1)
    end

    it "fetches the rides for the trip" do
      expect(FetchRidesJob).to have_enqueued_sidekiq_job(subject.id)
    end

    context "the trip is ongoing" do
      subject { Trip.create_and_populate_rides!(rider, attributes_for(:trip), true) }

      it "creates the trip with a nil end date" do
        subject
        expect(Trip.last.end_date).to be_nil
      end
    end
  end
end
