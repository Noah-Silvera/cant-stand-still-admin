class Ride < ApplicationRecord
  belongs_to :rider, foreign_key: :user_id
  belongs_to :trip, optional: true
end
