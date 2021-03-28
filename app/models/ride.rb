class Ride < ApplicationRecord
  belongs_to :rider, foreign_key: :user_id
  belongs_to :trip, optional: true

  serialize :map, JSON

  def map
    activity_json["map"]
  end
end
