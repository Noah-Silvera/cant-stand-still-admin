class Trip < ApplicationRecord
  has_many :rides
  belongs_to :rider, primary_key: "user_id", foreign_key: "user_id"
end
