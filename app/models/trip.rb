class Trip < ApplicationRecord
  belongs_to :rider, primary_key: "user_id", foreign_key: "user_id"

  validate :trip_name_not_empty
  validate :start_before_end_date

  class << self
    def allowed_attributes
      [:id, :name, :start_date, :end_date, :user_id]
    end

    def create_and_populate_rides!(rider, attributes, ongoing)
      trip = rider.trips.create!(attributes)
      if ongoing
        trip.update!(end_date: nil)
      end
      trip
    end
  end

  def rides
    rides = rider.rides.where("start_date > ?", start_date)
    if end_date
      rides = rides.where("start_date < ?", end_date)
    end
    rides
  end

  private

  def trip_name_not_empty
    if name.length == 0
      errors.add(:name, "cannot be empty")
    end
  end

  def start_before_end_date
    if end_date && start_date > end_date
      errors.add(:start_date, "start date must be before end date")
    end
  end
end
