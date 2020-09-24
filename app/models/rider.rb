class Rider < ApplicationRecord
  has_many :rides
  has_many :trips, primary_key: :user_id, foreign_key: :user_id
  encrypts :access_token, :refresh_token
end
