class AddRiderRefToTrips < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :rider, null: false, foreign_key: true
  end
end
