class Rider < ApplicationRecord
  has_many :rides, foreign_key: :user_id, dependent: :destroy
  has_many :trips, primary_key: :user_id, foreign_key: :user_id, dependent: :destroy
  encrypts :access_token, :refresh_token

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      Rider.find_by(user_id: auth_hash["uid"])
    end
  end

  def first_name
    athlete_json["firstname"]
  end

  def last_name
    athlete_json["lastname"]
  end

  def profile_picture_medium
    athlete_json["profile_medium"]
  end

  def profile_picture
    athlete_json["profile"]
  end
end
