class Rider < ApplicationRecord
  has_many :rides, foreign_key: :user_id
  has_many :trips, primary_key: :user_id, foreign_key: :user_id
  encrypts :access_token, :refresh_token

  def first_name
    athlete_json["firstname"]
  end

  def last_name
    athlete_json["lastname"]
  end
end
