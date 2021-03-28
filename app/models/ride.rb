class Ride < ApplicationRecord
  belongs_to :rider, foreign_key: :user_id
  belongs_to :trip, optional: true

  serialize :map, JSON
  serialize :name, JSON
  serialize :distance_km, JSON
  serialize :average_speed, JSON

  class << self
    def allowed_attributes
      [
        :id,
        :start_date,
        :map,
        :user_id,
        :name,
        :distance_km,
        :average_speed
      ]
    end
  end

  def name
    activity_json["name"]
  end

  def map
    activity_json["map"]
  end

  def distance_km
    activity_json["distance"] / 1000.0
  end

  def average_speed
    activity_json["average_speed"]
  end
end
