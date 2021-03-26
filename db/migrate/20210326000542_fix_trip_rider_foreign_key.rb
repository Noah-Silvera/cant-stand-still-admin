class FixTripRiderForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :trips, :riders
    add_foreign_key :trips, :riders, primary_key: "user_id", column: "user_id"
  end
end
