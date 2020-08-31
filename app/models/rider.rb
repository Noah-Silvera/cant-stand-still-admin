class Rider < ApplicationRecord
  has_many :rides
  has_many :trips
  encrypts :access_token, :refresh_token
end
