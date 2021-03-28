class Ride < ApplicationRecord
  belongs_to :rider, foreign_key: :user_id
  belongs_to :trip, optional: true

  serialize :map, JSON

  class << self
    def allowed_attributes
      [:id, :start_date, :map, :user_id]
    end
  end

  def map
    activity_json["map"]
  end
end
