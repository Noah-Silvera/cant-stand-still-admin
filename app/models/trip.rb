class Trip < ApplicationRecord
  has_many :rides
  belongs_to :rider
end
