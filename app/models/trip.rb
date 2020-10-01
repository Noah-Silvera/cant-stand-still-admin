class Trip < ApplicationRecord
  has_many :rides
  belongs_to :rider, foreign_key: :user_id
end
