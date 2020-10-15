class AddAccessTokenExpiresAtToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :access_token_expires_at, :datetime, null: false, default: Time.zone.now
  end
end
