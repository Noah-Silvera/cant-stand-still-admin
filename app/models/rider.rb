class Rider < ApplicationRecord
  has_many :rides
  has_many :trips
end
