class Rider < ApplicationRecord
  has_many :rides, foreign_key: :user_id, dependent: :destroy
  has_many :trips, primary_key: :user_id, foreign_key: :user_id, dependent: :destroy
  encrypts :access_token, :refresh_token

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      case auth_hash["provider"]
      when "developer"
        Rider.find_by(user_id: auth_hash["uid"])
      when "strava"
        rider = Rider.find_by(user_id: auth_hash["uid"])
        if rider
          rider.update!(
            access_token: auth_hash["info"]["access_token"],
            refresh_token: auth_hash["info"]["refresh_token"],
            access_token_expires_at: auth_hash["info"]["expires_at"],
            athlete_json: auth_hash["info"]["athlete_json"]
          )
        else
          rider = Rider.create!(
            user_id: auth_hash["uid"],
            access_token: auth_hash["info"]["access_token"],
            refresh_token: auth_hash["info"]["refresh_token"],
            access_token_expires_at: auth_hash["info"]["expires_at"],
            athlete_json: auth_hash["info"]["athlete_json"]
          )
        end
        rider
      end
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
